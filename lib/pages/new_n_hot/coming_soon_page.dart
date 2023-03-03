import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/common/common_functions.dart';
import 'package:netflix_clone/pages/new_n_hot/new_n_hot_functions.dart';

import '../../common/common_variables.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/model_class.dart';
import 'package:http/http.dart' as http;

class ComingSoonPage extends StatelessWidget {
  ComingSoonPage({required this.obj, super.key});

  ModelClass? obj;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "   🍿 Coming Soon",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Expanded(
            child: ListView.builder(
          itemCount: obj?.results.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 40),

                      Text(
                        obj?.results[index].releaseDate == null
                            ? ''
                            : monthFromDate(obj?.results[index].releaseDate),
                        style: TextStyle(fontSize: 25),
                      ),
                      // Text(
                      //  obj.results[index].releaseDate.month == null '' : obj!.results[index]!.releaseDate!.month!  ,
                      //   style: TextStyle(fontSize: 25),
                      // ),
                      Text(
                        obj?.results[index].releaseDate?.day.toString() ?? '',
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  height: 500,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.yellow,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$baseImageUrl${obj?.results[index].backdropPath}'),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .75,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Row(children: [
                          Text(
                            obj == null
                                ? 'Loading...'
                                : truncateWithEllipsis(
                                    5, obj!.results[index].originalTitle!),
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 30),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Icon(FontAwesomeIcons.bell),
                              Text("Remind Me"),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Icon(Icons.info_outline),
                              Text('Info'),
                            ],
                          )
                        ]),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                          obj == null
                              ? 'Loading...'
                              : truncateWithEllipsis(
                                  35, obj!.results[index].originalTitle!),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                          obj == null
                              ? 'Loading...'
                              : '          ${obj!.results[index].overview!}',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ))
      ],
    );
  }
}
