import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kgamify/bloc/catergories_bloc.dart';
import 'package:kgamify/bloc/game_mode_bloc.dart';
import 'package:kgamify/bloc/questions_bloc.dart';
import 'package:kgamify/bloc/theme_bloc.dart';
import 'package:kgamify/bloc/timer/timer_bloc.dart';
import 'package:kgamify/screens/sign_up.dart';
import 'package:kgamify/utils/exports.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("UserData");
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("5c421eb8-340d-4e8a-b5f2-ff95c48a9d1b");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => TimerBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => GameModeBloc(),
        ),
        BlocProvider(
          create: (context) => QuestionsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'kGamify',
        supportedLocales: const [
          Locale("en"),
          Locale("hi")
        ],
        // locale: const Locale("en"),
        locale: Hive.box("UserData").get("locale",defaultValue: null) == null ? Locale(Platform.localeName) : Locale(Hive.box("UserData").get("locale",defaultValue: null)),
        localizationsDelegates: const[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white)
        ),
        debugShowCheckedModeBanner: kDebugMode,
        home: LayoutBuilder(builder: (context, constraints) {
          if (Hive.box("UserData").get("locale",defaultValue: null) == null){
            return const LocaleSelection();
          }
          else if(!Hive.box("UserData").get("isLoggedIn",defaultValue: false)){
            return const SignUp();
          }
          return const LandingPage();
        },),
      ),
    );
  }
}
