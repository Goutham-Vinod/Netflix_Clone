import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/model_class.dart';
import 'package:netflix_clone/common/common_variables.dart';

class Showcase extends StatefulWidget {
  Showcase({required this.title, required this.path, super.key});

  String title;
  String path;

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  ModelClass? trendingMoviesObj;

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
      trendingMoviesObj = ModelClass.fromJson(trendingMoviesResults);
    }

    randomObj = trendingMoviesObj;
    return trendingMoviesObj;
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
                    itemCount: trendingMoviesObj?.results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Container(
                            width: 140,
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(trendingMoviesObj
                                                  ?.results[index].posterPath ==
                                              null
                                          ? kImageErrorUrl
                                          : baseImageUrl +
                                              trendingMoviesObj!.results[index]
                                                  .posterPath!))),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: const Text("Loading..."));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
