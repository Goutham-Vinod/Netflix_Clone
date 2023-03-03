import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/common/common_variables.dart';
import 'package:netflix_clone/screens/home_page_screen.dart';
import 'package:netflix_clone/screens/new_n_hot_page_screen.dart';
import 'package:netflix_clone/screens/not_available.dart';
import 'screens/downloads_screen.dart';
import 'widgets/showcase.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNaviIndex = 0;

  List screens = [
    HomeScreen(),
    NotAvailable(),
    NewNHotScreen(),
    NotAvailable(),
    DownloadsScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      body: screens[currentNaviIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: currentNaviIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.games_outlined), label: 'Games'),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_outlined), label: 'New & Hot'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions_outlined), label: 'Fast laughs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined), label: 'Downloads')
        ],
        onTap: (value) {
          setState(() {
            if (value != 1 && value != 3) {
              currentNaviIndex = value;
            }
          });
        },
      ),
    );
  }
}
