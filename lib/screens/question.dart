import 'package:flutter/material.dart';
import 'package:kgamify/bloc/timer/timer_bloc.dart';
import 'package:kgamify/screens/quiz_result.dart';
import 'package:kgamify/utils/models/questions_model.dart';
import 'package:kgamify/utils/widgets.dart';
import '../utils/exports.dart';

class Question extends StatefulWidget {
  final List<QuestionsModel> questionsList;
  const Question({super.key, required this.questionsList});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int seconds = 10 * 60;

  @override
  void initState() {
    // TODO: implement initState
    context.read<TimerBloc>().startTimer((seconds), context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // context.read<TimerBloc>().resetTimer();
    super.dispose();
  }

  String? selectedAns;
  int? currentIndex;
  int score = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Mind Marathon"),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Quit"),
                      content: const Text("Are you sure you want to quit?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.read<TimerBloc>().resetTimer();
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => QuizResult(
                                      score: score,
                                      solvedQuestions: currentIndex!,
                                      totalQuestions: widget.questionsList.length,
                                    ),
                                  ));
                            },
                            child: const Text("Yes")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.questionsList.length,
        controller: pageController,
        itemBuilder: (context, index) {
          currentIndex = index + 1;
          // final curr = widget.questionsList.elementAt(index).
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text("Mind Marathon",style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
                const Divider(
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined),
                        BlocBuilder<TimerBloc, String>(
                          builder: (context, state) {
                            return Text(state.toString());
                          },
                        )
                      ],
                    ),
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.question_answer),
                        Text("$currentIndex/${widget.questionsList.length}")
                      ],
                    ),
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [const Icon(Icons.attach_money), Text("Coins : $score")],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width * 0.05),
                  padding: const EdgeInsets.all(8),
                  child: AutoSizeText(
                      "$currentIndex) ${widget.questionsList.elementAt(index).option1Text}",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                AutoSizeText(
                  "Options",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    // answerTile(index, widget.questionsList.elementAt(index).option1Text, selectedAns),
                    answerTile(
                      index,
                      widget.questionsList.elementAt(index).option2Text,
                      selectedAns,
                      () {
                        setState(() {
                          selectedAns = widget.questionsList.elementAt(index).option2Text;
                        });
                      },
                    ),
                    answerTile(
                      index,
                      widget.questionsList.elementAt(index).option3Text,
                      selectedAns,
                      () {
                        setState(() {
                          selectedAns = widget.questionsList.elementAt(index).option3Text;
                        });
                      },
                    ),
                    answerTile(
                      index,
                      widget.questionsList.elementAt(index).option4Text,
                      selectedAns,
                      () {
                        setState(() {
                          selectedAns = widget.questionsList.elementAt(index).option4Text;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      5,
                      (index) {
                        return Icon(Icons.close);
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
        child: ElevatedButton(
          onPressed: () {
            if (currentIndex == widget.questionsList.length) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Do you want to submit and exit the championship."),
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (route) => route is LandingPage,
                            );
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => QuizResult(
                                    score: score,
                                    solvedQuestions: currentIndex!,
                                    totalQuestions: widget.questionsList.length,
                                  ),
                                ));
                          },
                          child: const Text("Yes")),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"))
                    ],
                  );
                },
              );
            }
            setState(() {
              selectedAns = null;
            });
            pageController.nextPage(
                duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          style: elevatedButtonTheme(context),
          child: const Text("Next"),
        ),
      ),
    );
  }

  Widget answerTile(int index, String? ans, String? selectedAns, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width * 0.03),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(color: Colors.orange)),
          borderRadius: BorderRadius.circular(10),
          color: ans == selectedAns
              ? Colors.orange.withOpacity(0.3)
              : Theme.of(context).colorScheme.surface,
        ),
        child: AutoSizeText(ans ?? "", style: Theme.of(context).textTheme.titleMedium!
            // .copyWith(color: ans != selectedAns ? Colors.black : Colors.white),
            ),
      ),
    );
  }
}
