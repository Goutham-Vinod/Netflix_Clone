import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix_clone/common/common_variables.dart';
import 'package:netflix_clone/model/model_class.dart';
import 'package:http/http.dart' as http;

import '../common/common_functions.dart';
import '../pages/new_n_hot/Everyone_watching_page.dart';
import '../pages/new_n_hot/coming_soon_page.dart';

class NewNHotScreen extends StatefulWidget {
  NewNHotScreen({super.key});

  @override
  State<NewNHotScreen> createState() => _NewNHotScreenState();
}

class _NewNHotScreenState extends State<NewNHotScreen> {
  ModelClass? comingSoonObj;
  ModelClass? everyoneWatchingObj;

  loadEveryoneWatching() async {
    final everyoneWatchingResponse =
        await http.get(Uri.parse("$baseUrl/movie/top_rated?api_key=$apiKey"));
    if (everyoneWatchingResponse.statusCode == 200) {
      Map<String, dynamic> results = json.decode(everyoneWatchingResponse.body);
      everyoneWatchingObj = ModelClass.fromJson(results);
    }
    return everyoneWatchingObj;
  }

  loadComingSoon() async {
    final comingSoonResponse =
        await http.get(Uri.parse("$baseUrl/movie/upcoming?api_key=$apiKey"));
    if (comingSoonResponse.statusCode == 200) {
      Map<String, dynamic> results = json.decode(comingSoonResponse.body);
      comingSoonObj = ModelClass.fromJson(results);
    }
    return comingSoonObj;
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "New & Hot",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.bell)),
            SizedBox(width: 15),
            Image.asset(
              "assets/user_dp.png",
              width: 30,
            ),
            SizedBox(width: 15)
          ],
          bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              tabs: [
                SizedBox(
                  height: 30,
                  child: Tab(
                    text: "🍿 Coming Soon",
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Tab(
                    text: "🔥 Everyone's Watching",
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          FutureBuilder(
            future: loadComingSoon(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ComingSoonPage(obj: comingSoonObj);
              } else {
                return Center(child: Text('Loading...'));
              }
            },
          ),
          FutureBuilder(
              future: loadEveryoneWatching(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return EveryoneWatchingPage(obj: everyoneWatchingObj);
                } else {
                  return Center(child: Text("Loading..."));
                }
              }),
        ]),
      ),
    );
  }
}
