import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kgamify/bloc/catergories_bloc.dart';
import 'package:kgamify/bloc/game_mode_bloc.dart';
import 'package:kgamify/bloc/questions_bloc.dart';
import 'package:kgamify/bloc/theme_bloc.dart';
import 'package:kgamify/bloc/timer/timer_bloc.dart';
import 'package:kgamify/utils/exports.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("UserData");
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: kDebugMode,
        home: LayoutBuilder(builder: (context, constraints) {
          if (Hive.box("UserData").get("locale",defaultValue: null) == null){
            return const LocaleSelection();
          }
          // else if(Hive.box("UserData").get("userName",defaultValue: null) == null){
          //   return const SignUp();
          // }
          return const LandingPage();
        },),
      ),
    );
  }
}
