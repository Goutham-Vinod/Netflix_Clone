import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/pages/common.dart';
import 'package:netflix_clone/pages/downloads_page.dart';
import 'package:netflix_clone/pages/home_page.dart';
import 'package:netflix_clone/pages/new_n_hot_page.dart';
import 'package:netflix_clone/pages/not_available.dart';
import 'package:netflix_clone/response_model.dart';
import 'package:netflix_clone/showcase.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentNaviIndex = 0;

  List screens = [
    HomePage(),
    NotAvailable(),
    NewNHotPage(),
    NotAvailable(),
    DownloadsPage()
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
