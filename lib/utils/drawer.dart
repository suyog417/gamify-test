import 'package:flutter/material.dart';
import 'package:kgamify/screens/user_profile.dart';
import 'package:kgamify/utils/exports.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: Hero(
                tag: "UserPfp",
                child: CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width * 0.15,
                  backgroundImage:
                      MemoryImage(Hive.box("UserData").get("UserImage", defaultValue: null)),
                  onBackgroundImageError: (exception, stackTrace) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(exception.toString())));
                  },
                ),
              ),
              accountName: Text(Hive.box("UserData").get("personalInfo")['name']),
              accountEmail: Text(Hive.box("UserData").get("personalInfo")['email'])),
          ListTile(
            title: Text(AppLocalizations.of(context)!.myAccount),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UserProfile(),
                  ));
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.analytics),
            leading: const Icon(Icons.bar_chart),
          ),
          const Spacer(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.logOut),
            leading: const Icon(Icons.logout_outlined),
            onTap: () {
              Hive.box("UserData").put("isLoggedIn", false);
              Hive.box("UserData").delete("locale").whenComplete(
                () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LocaleSelection(),
                      ));
                },
              );
            },
          )
        ],
      ),
    );
  }
}
