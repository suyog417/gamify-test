import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(width: 100, height: 100),
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
