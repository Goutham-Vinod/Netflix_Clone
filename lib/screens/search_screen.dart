import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/common/common_functions.dart';
import 'package:netflix_clone/common/common_variables.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
              child: CupertinoSearchTextField(
                style: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Top Searches',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: randomObj?.results.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * .40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '$baseImageUrl${randomObj?.results[index].backdropPath}'))),
                          ),
                          Text(
                            truncateWithEllipsis(
                                20, '   ${randomObj?.results[index].title}'),
                            style: TextStyle(fontSize: 15),
                          ),
                          Spacer(),
                          Icon(
                            Icons.play_circle_fill,
                            size: 35,
                          )
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
