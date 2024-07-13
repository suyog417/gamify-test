import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/screens/quiz_result.dart';

class TimerBloc extends Cubit<String>{
  TimerBloc() : super("0:00");
  final stopWatch = Stopwatch();
  Timer? _timer;

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  void startTimer(int seconds,BuildContext context){
    int remaining = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      stopWatch.start();
      emit(formattedTime(timeInSecond: remaining));
      remaining--;
      if(stopWatch.elapsed.inSeconds == seconds){
        stopWatch.stop();
        stopWatch.reset();
        _timer?.cancel();
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const QuizResult(),));
      }
    },);
  }

  void resetTimer(){
    stopWatch.reset();
    stopWatch.stop();
    _timer?.cancel();
    emit("0:00");
  }
  @override
  Future<void> close() {
    stopWatch.stop();
    stopWatch.reset();
    _timer?.cancel();
    // TODO: implement close
    return super.close();
  }
}