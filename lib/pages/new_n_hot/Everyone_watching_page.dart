import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix_clone/common/common_functions.dart';
import 'package:netflix_clone/model/model_class.dart';

import '../../common/common_variables.dart';

class EveryoneWatchingPage extends StatelessWidget {
  EveryoneWatchingPage({required this.obj, super.key});

  ModelClass? obj;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "   🔥 Everyone's Watching",
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        obj == null
                            ? 'Loading...'
                            : truncateWithEllipsis(
                                35, obj!.results[index].originalTitle!),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .88,
                        child: Text(
                          obj == null
                              ? 'Loading...'
                              : '          ${obj!.results[index].overview!}',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(obj == null
                                    ? kImageErrorUrl
                                    : '$baseImageUrl${obj!.results[index].backdropPath!}'),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .88,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 200),
                          Column(
                            children: [
                              Icon(FontAwesomeIcons.arrowUpFromBracket),
                              Text("Share"),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Icon(Icons.add),
                              Text("My List"),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Icon(Icons.play_arrow),
                              Text("Play"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
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
