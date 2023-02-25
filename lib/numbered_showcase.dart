import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NumberedShowcase extends StatelessWidget {
  NumberedShowcase(
      {required this.showcaseContent, required this.title, super.key});
  String title;
  List showcaseContent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: showcaseContent.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: Stack(
                      children: [
                        Container(
                          width: 140,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            showcaseContent[index]
                                                ['poster_path']))),
                          ),
                        ),
                        Positioned(
                            left: -7,
                            bottom: 70,
                            child: BorderedText(
                                strokeWidth: 8,
                                strokeColor: Colors.white,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      fontSize: 75, color: Colors.black),
                                ))),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
}
