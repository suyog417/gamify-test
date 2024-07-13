import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kgamify/bloc/game_mode_bloc.dart';
import 'package:kgamify/screens/select_game_mode.dart';

import 'models/game_mode_model.dart';

class ChampionshipInfo extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String champId;
  final String categoryId;
  final String champName;
  final String categoryName;
  const ChampionshipInfo(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.champId,
      required this.categoryId,
      required this.champName,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => SelectGameMode(champId: int.parse(champId),),));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: const Border.fromBorderSide(BorderSide(color: Colors.orange, width: 1.5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Quick Hit",style: TextStyle(color: Colors.red),),IconButton(onPressed: () {

              }, icon: const Icon(Icons.info_outline),style: IconButton.styleFrom(
                padding: EdgeInsets.zero
              ),)],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                champName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(categoryName),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person),
                Text("5 M")
              ],
            ),
            const Divider(),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text.rich(TextSpan(
                       text: "Qualification :",
                       style: TextStyle(
                           fontWeight: FontWeight.bold
                       ),
                       children: [
                         TextSpan(
                             text: "any",
                             style: TextStyle(fontWeight: FontWeight.normal)
                         )
                       ]
                   ),
                   ),
                   Text.rich(TextSpan(
                       text: "Start Time :",
                       style: const TextStyle(
                           fontWeight: FontWeight.bold
                       ),
                       children: [
                         TextSpan(
                             text: "${startDate + startTime}",
                             style: const TextStyle(fontWeight: FontWeight.normal)
                         )
                       ]
                   ),
                   ),
                   Text.rich(TextSpan(
                     text: "End Time :",
                     style: const TextStyle(
                       fontWeight: FontWeight.bold
                     ),
                     children: [
                       TextSpan(
                         text: "${endDate + endTime}",
                         style: const TextStyle(fontWeight: FontWeight.normal)
                       )
                     ]
                   ),
                   ),
                   // Text("Category Name: $categoryName")
                 ],
               ),
               const CircleAvatar(
                 // backgroundImage: Image(image: NetworkImage("https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg"),),
                 backgroundImage: NetworkImage("https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg"),
                 radius: 24,
               ),
             ],
           )
          ],
        ),
      ),
    );
  }
}
