import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/screens/quiz_result.dart';

///Functionalities for
class TimerBloc extends Cubit<String> {
  TimerBloc() : super("0:00");
  Timer? _timer;

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  void startTimer(int seconds, BuildContext context) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          emit(formattedTime(timeInSecond: seconds));
        } else {
          // _timer?.cancel();
          Navigator.popUntil(
            context,
            (route) => route.isFirst,
          );
          Navigator.push(
              context,
              CupertinoDialogRoute(
                  builder: (context) => const QuizResult(
                        totalQuestions: 0,
                        solvedQuestions: 0,
                        score: 0,
                      ),
                  context: context));
        }
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    emit("0:00");
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    // TODO: implement close
    return super.close();
  }
}
