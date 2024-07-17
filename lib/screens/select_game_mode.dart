import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/bloc/game_mode_bloc.dart';
import 'package:kgamify/bloc/timer/timer_bloc.dart';
import 'package:kgamify/screens/question.dart';

class SelectGameMode extends StatefulWidget {
  final int champId;
  const SelectGameMode({super.key,required this.champId});

  @override
  State<SelectGameMode> createState() => _SelectGameModeState();
}

class _SelectGameModeState extends State<SelectGameMode> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<GameModeBloc>().getGameModes(champId: widget.champId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    GameModeBloc().close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Game Mode"),
      ),
      body: BlocBuilder<GameModeBloc, GameModeStates>(
  builder: (context, state) {
    if (state is GameModeLoadedState){
      if(state.models!.isEmpty){
        return const Center(child: Text("No game modes available"),);
      }
      else{
        return ListView.builder(
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: state.models!.length,
          itemBuilder: (BuildContext context, int index) {
            final curr = state.models!.elementAt(index);
            return GameModes(modeId: curr.modeId!, modeName: curr.modeName!, timeMinutes: curr.timeMinutes!, noOfQuestions: curr.noOfQuestion!);
          },);
      }
    }
    if(state is GameModeLoadingState){
      return const Center(child: CircularProgressIndicator(),);
    }
    return const Center(child: Text("An error occured"),);

  },
)
    );
  }
}


class GameModes extends StatelessWidget {
  final String modeId;
  final String modeName;
  final String timeMinutes;
  final String noOfQuestions;
  const GameModes({super.key, required this.modeId, required this.modeName, required this.timeMinutes, required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const Question(questionsList: [],),)).then((value) {
          context.read<TimerBloc>().startTimer(60 * 4,context);
        },);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.start,
              buttonPadding: EdgeInsets.zero,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.alarm,size: Theme.of(context).textTheme.displaySmall!.fontSize,),
                const VerticalDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quick Hit | $noOfQuestions Questions",style: Theme.of(context).textTheme.titleMedium,),
                    const Text('Random questions and time limit.')
                  ],
                ),],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(timeMinutes,style: Theme.of(context).textTheme.titleLarge,),
                  const Text("mins")
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
