import 'package:flutter/material.dart';
import 'package:kgamify/utils/exports.dart';
import 'package:kgamify/utils/widgets.dart';

class QuizResult extends StatefulWidget {
  final int totalQuestions;
  final int score;
  final int solvedQuestions;
  const QuizResult(
      {super.key,
      required this.totalQuestions,
      required this.score,
      required this.solvedQuestions});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  int correct = 4;
  int total = 9;
  int points = 50;

  @override
  void dispose() {
    // TODO: implement dispose
    FocusManager.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            const AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage("assets/images/celebration.png"),
              ),
            ),
            AutoSizeText(
              "Your Score",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AutoSizeText(
              "${widget.solvedQuestions}/${widget.totalQuestions}",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            AutoSizeText("Congratulations",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.orange)),
            AutoSizeText(
              "Great job ${Hive.box("UserData").get("personalInfo")['name']}, You have done well.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: ButtonBar(
                    buttonPadding: const EdgeInsets.all(4),
                    children: [
                      const Icon(Icons.monetization_on_rounded),
                      AutoSizeText(
                        "${widget.score.toString()} points",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  foregroundColor: Colors.orange),
              child: const AutoSizeText(
                "View Analytics",
                maxLines: 1,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LandingPage(),
                    ));
              },
              style: elevatedButtonTheme(context),
              child: const AutoSizeText(
                "Explore more championships",
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
