import 'package:flutter/material.dart';
import 'package:kgamify/bloc/timer/timer_bloc.dart';
import 'package:kgamify/screens/quiz_result.dart';
import 'package:kgamify/utils/models/questions_model.dart';
import '../utils/exports.dart';

class Question extends StatefulWidget {
  final List<Questions> questionsList;
  const Question({super.key, required this.questionsList});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  List<String> answers = [
    "A","B","C","D"
  ];

  @override
  void initState() {
    // TODO: implement initState
    context.read<TimerBloc>().startTimer((60*4), context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TimerBloc().close();
    super.dispose();
  }
  String? selectedAns;
  int? currentIndex;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlayQuest"),
        elevation: 0,
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(title: const Text("Quit"),
                content: const Text("Are you sure you want to quit?"),
                actions: [
                  TextButton(onPressed: () {
                    context.read<TimerBloc>().resetTimer();
                    Navigator.popUntil(context, (route) => route.isFirst,);
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const QuizResult(),));
                  }, child: const Text("Yes")),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("No")),
                ],);
            },);
          }, icon: const Icon(Icons.close))
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        controller: pageController,
        itemBuilder: (context, index) {
          currentIndex = index + 1;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Championship Name",style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
                const Divider(color: Colors.transparent,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined),
                        BlocBuilder<TimerBloc,String>(builder: (context, state) {
                          return Text(state.toString());
                        },)
                      ],
                    ),
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.question_answer),
                        Text("$currentIndex/9")
                      ],
                    ),
                    const ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_money),
                        Text("Coins : 0")
                      ],
                    )

                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical : MediaQuery.sizeOf(context).width * 0.05),
                  padding: const EdgeInsets.all(8),
                  child: AutoSizeText("$currentIndex) Question ?",style: Theme.of(context).textTheme.titleMedium),
                ),
                AutoSizeText("Options",style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.start,),
                const Divider(color: Colors.transparent,),
                ListView.builder(
                  itemCount: answers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedAns = answers.elementAt(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width * 0.03),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: answers[index] == selectedAns ? Colors.orange : Colors.white,
                        ),
                        child: Text(answers[index],style: Theme.of(context).textTheme.titleMedium,),
                      ),
                    );
                  },),
              ],
            ),
          );
      },),
      bottomSheet: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
        child: ElevatedButton(onPressed: () {
          if(currentIndex == 5) {
            showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: const Text("Do you want to submit and exit the championship."),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
              ElevatedButton(onPressed: () {}, child: const Text("Yes")),
                OutlinedButton(onPressed: () {}, child: const Text("No"))
            ],);
          },);
          }
          pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite)
        ), child: const Text("Submit"),),
      ),
    );
  }
}
