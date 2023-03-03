import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SizedBox(
            height: 100, child: Image.asset("assets/netflix_logo.png")),
      ),
    );
  }

  @override
  void initState() {
    splashScreenFunctions();
    super.initState();
  }

  Future<void> splashScreenFunctions() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return Home();
    }));
  }
}
