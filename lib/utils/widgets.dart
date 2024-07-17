import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kgamify/screens/question.dart';
import 'package:kgamify/utils/exports.dart';

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
    final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
    final formattedStartDate = DateTime.parse("$startDate $startTime");
    final formattedEndDate = DateTime.parse("$endDate $endTime");
    final start = DateFormat("MMMEd").format(DateTime.parse("$startDate $startTime"));
    final end = DateFormat("MMMEd").format(DateTime.parse("$endDate $endTime"));
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const Question(questionsList: []),
            ));
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
              children: [
                const Text(
                  "Quick Hit",
                  style: TextStyle(color: Colors.red),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          insetPadding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.07),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text("About Championship"),
                                const Divider(
                                  color: Colors.transparent,
                                ),
                                const AutoSizeText('''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'''),
                                const Divider(
                                  color: Colors.transparent,
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: elevatedButtonTheme(context),
                                  child: const Text("Ok"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    if (kDebugMode) {
                      print("Opened Info");
                    }
                  },
                  child: const Icon(Icons.info_outline_rounded),
                )
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                champName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(categoryName),
              trailing: LayoutBuilder(builder: (context, constraints) {
                if (DateTime.parse(formattedStartDate.toString()).isAfter(DateTime.now())){
                  return Container(
                    decoration: BoxDecoration(
                        border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel_outlined,size: 14,color: Colors.grey,),
                        Text(
                          " Upcoming",
                          style: TextStyle(color: Colors.grey,fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                else if(DateTime.parse(formattedEndDate.toString()).isBefore(DateTime.now())) {
                  return Container(
                    decoration: BoxDecoration(
                        border: const Border.fromBorderSide(BorderSide(color: Colors.redAccent)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel_outlined,size: 14,color: Colors.redAccent,),
                        Text(
                          " Ended",
                          style: TextStyle(color: Colors.redAccent,fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                      border: const Border.fromBorderSide(BorderSide(color: Colors.green)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.all(3),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.ellipsis_circle,size: 14,color: Colors.green,),
                      Text(
                        " Ongoing",
                        style: TextStyle(color: Colors.green,fontSize: 14),
                      ),
                    ],
                  ),
                );
              },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  "4 Questions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.person),
                    Text(formatter.format(50000000),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.normal
                    ),),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      children: [
                        Icon(Icons.school_outlined),
                        VerticalDivider(),
                        AutoSizeText("B.Tech")
                      ],
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      children: [
                        const Icon(Icons.calendar_month),
                        const VerticalDivider(),
                        ButtonBar(
                          children: [
                            Column(
                              children: [
                                Text("From : "),
                                Text("To : ")
                              ],
                            ),
                            Column(
                              children: [
                                Text(start),
                                Text(end)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Hero(
                  tag: "teacher-profile-picture",
                  transitionOnUserGestures: true,
                  child: InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return Dialog(
                          insetPadding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.07),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Hero(tag: "teacher-profile-picture", child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg"),
                                  radius: 62,
                                )),
                                const Text("Teacher Name"),
                                const Text("Teacher Qualification"),
                                ElevatedButton(onPressed: (){},style: elevatedButtonTheme(context), child: const Text("View Profile"),)
                              ],
                            ),
                          ),
                        );
                      },);
                    },
                    child: const CircleAvatar(
                      // backgroundImage: Image(image: NetworkImage("https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg"),),
                      backgroundImage: NetworkImage(
                          "https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg"),
                      radius: 24,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

ButtonStyle elevatedButtonTheme(BuildContext context) {
  return ElevatedButton.styleFrom(
      fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.orangeAccent,
      foregroundColor: Colors.white,
  );
}
