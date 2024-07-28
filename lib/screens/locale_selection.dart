import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kgamify/utils/exports.dart';

class LocaleSelection extends StatefulWidget {
  const LocaleSelection({super.key});

  @override
  State<LocaleSelection> createState() => _LocaleSelectionState();
}

class _LocaleSelectionState extends State<LocaleSelection> {
  String locale = "en";
  Map<String, List> localeData = {
    "en": ["assets/flags/us.svg", "English"],
    "hi": ["assets/flags/in.svg", "Hindi"]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            AppLocalizations.of(context)!.selectALanguageToProceed,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListView.builder(
            itemCount: localeData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => setState(() {
                  locale = localeData.keys.elementAt(index);
                }),
                child: LocaleTiles(
                  localeName: localeData.keys.elementAt(index),
                  countryName: localeData[localeData.keys.elementAt(index)]!.last,
                  svgPath: localeData[localeData.keys.elementAt(index)]!.first,
                  color: localeData.keys.elementAt(index) == locale
                      ? Colors.orangeAccent
                      : Colors.white,
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ElevatedButton(
            onPressed: () {
              Hive.box("UserData").put("locale", locale).whenComplete(
                () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LandingPage(),
                      )).whenComplete(
                    () => setState(() {}),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width)),
            child: const Text("Proceed"),
          )
        ],
      ),
    ));
  }
}

class LocaleTiles extends StatefulWidget {
  final String localeName;
  final String svgPath;
  final Color color;
  final String countryName;
  const LocaleTiles(
      {super.key,
      required this.localeName,
      required this.svgPath,
      required this.color,
      required this.countryName});

  @override
  State<LocaleTiles> createState() => _LocaleTilesState();
}

class _LocaleTilesState extends State<LocaleTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width * 0.05),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.15),
      decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(color: Colors.orange, width: 1.5)),
          borderRadius: BorderRadius.circular(10),
          color: widget.color),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.25,
            width: MediaQuery.sizeOf(context).width * 0.15,
            child: SvgPicture.asset(
              widget.svgPath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            widget.countryName,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
