import 'dart:convert';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/model_class.dart';
import 'package:netflix_clone/common/common_variables.dart';

class NumberedShowcase extends StatefulWidget {
  NumberedShowcase({required this.title, required this.path, super.key});

  String title;
  String path;

  @override
  State<NumberedShowcase> createState() => _NumberedShowcaseState();
}

class _NumberedShowcaseState extends State<NumberedShowcase> {
  ModelClass? obj;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadData();
    });
  }

  loadData() async {
    final trendingMoviesResponse = await http.get(Uri.parse(widget.path));
    if (trendingMoviesResponse.statusCode == 200) {
      Map<String, dynamic> trendingMoviesResults =
          json.decode(trendingMoviesResponse.body);
      obj = ModelClass.fromJson(trendingMoviesResults);
    }
    return obj;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 225,
            child: FutureBuilder(
              future: loadData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: obj?.results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Stack(
                            children: [
                              Container(
                                width: 140,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(obj
                                                          ?.results[index]
                                                          .posterPath ==
                                                      null
                                                  ? kImageErrorUrl
                                                  : baseImageUrl +
                                                      obj!.results[index]
                                                          .posterPath!))),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 20,
                                  child: BorderedText(
                                      strokeWidth: 5,
                                      strokeColor: Colors.white,
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 70,
                                            color: Colors.black),
                                      ))),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Loading..."));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
