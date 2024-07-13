import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kgamify/utils/exports.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({super.key});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  int correct = 4;
  int total = 9;
  int points = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            AutoSizeText("You have correctly answered",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge,maxLines: 1,),
            AutoSizeText("$correct/$total",textAlign: TextAlign.center,style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent
            ),),
            const Spacer(),
            AutoSizeText(points.toString(),textAlign: TextAlign.center,style: const TextStyle(
              fontSize: 112,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent
            ),),
            AutoSizeText("Points",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            ElevatedButton(onPressed: () {

            }, child: const AutoSizeText("View Analytics",maxLines: 1,)),
            ElevatedButton(onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst,);
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const LandingPage(),));
            }, child: const AutoSizeText("Explore more championships",maxLines: 1,)),
          ],
        ),
      ),
    );
  }
}
