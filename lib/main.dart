import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/splash_screen.dart';
import 'home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set status bar color as transparent
      statusBarIconBrightness: Brightness.light, // Dark icon on status bar
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.red),
        home: SplashScreen());
  }
}
