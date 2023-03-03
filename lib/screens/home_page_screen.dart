import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/model/model_class.dart';
import 'package:netflix_clone/widgets/numbered_showcase.dart';
import 'package:netflix_clone/common/common_variables.dart';
import 'package:netflix_clone/widgets/showcase.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int appBarOpacy = 0; //255 max and 0 min
  ValueNotifier<bool> appBarVisibilityNotifier = ValueNotifier(false);
  final ScrollController scrollController = ScrollController();
  ValueNotifier<bool> appBarCategoriesVisibilityNotifier = ValueNotifier(true);
  bool upperGradVisibility = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (scrollNotification) {
        ScrollDirection scrollDirection = scrollNotification.direction;

        double currentScrollVal = getScrollControllerOffset();

        if (getScrollControllerOffset() < 500) {
          if (scrollDirection == ScrollDirection.forward) {
            appBarCategoriesVisibilityNotifier.value = true;
            appBarVisibilityNotifier.value = false;
            upperGradVisibility = false;
          }
          if (scrollDirection == ScrollDirection.reverse) {
            appBarCategoriesVisibilityNotifier.value = false;
            appBarVisibilityNotifier.value = false;
            upperGradVisibility = false;
          }
        } else {
          if (scrollDirection == ScrollDirection.forward) {
            appBarCategoriesVisibilityNotifier.value = true;
            appBarVisibilityNotifier.value = true;
            upperGradVisibility = false;
          }

          if (scrollDirection == ScrollDirection.reverse) {
            appBarCategoriesVisibilityNotifier.value = false;
            appBarVisibilityNotifier.value = false;
            upperGradVisibility = true;
          }
        }

        return false;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Stack(children: [
                      Image(
                        image: NetworkImage(kImageUrl2),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color.fromARGB(0, 0, 0, 0),
                                Color.fromARGB(193, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ])),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.add),
                                Text("My List"),
                              ],
                            ),
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "Play  ",
                                  style: TextStyle(color: Colors.black),
                                )),
                            Column(
                              children: [
                                Icon(Icons.info_outline),
                                Text("Info"),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                    Column(
                      children: [
                        Showcase(
                            title: "Popular movies",
                            path: "$baseUrl/movie/popular?api_key=$apiKey"),
                        NumberedShowcase(
                            title: "Top rated Movies",
                            path: "$baseUrl/tv/top_rated?api_key=$apiKey"),
                        Showcase(
                            title: "Popular TV Shows",
                            path: "$baseUrl/tv/popular?api_key=$apiKey"),
                        NumberedShowcase(
                            title: "Top rated TV shows",
                            path: "$baseUrl/tv/top_rated?api_key=$apiKey"),
                        Showcase(
                            title: "Upcomng Movies",
                            path: "$baseUrl/movie/upcoming?api_key=$apiKey"),
                        NumberedShowcase(
                            title: "Top Rated movies",
                            path: "$baseUrl/movie/top_rated?api_key=$apiKey"),
                        Showcase(
                            title: "Trending Movies",
                            path: "$baseUrl/trending/all/day?api_key=$apiKey"),
                        Showcase(
                            title: "Now Playing movies",
                            path: "$baseUrl/movie/now_playing?api_key=$apiKey"),
                        SizedBox(height: 80),
                      ],
                    )
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: appBarVisibilityNotifier,
                builder: (context, appBarVisibility, child) {
                  if (appBarVisibility) {
                    return Container(
                      // scroll down app bar container
                      width: MediaQuery.of(context).size.width,
                      height: 135,
                      color: Color.fromARGB(125, 0, 0, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                child: Image.asset(
                                  "assets/netflix_logo.png",
                                  height: 45,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 30, 15, 0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.search),
                                  iconSize: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 25, 0),
                                child: Image(
                                  image: AssetImage("assets/user_dp.png"),
                                  height: 35,
                                ),
                              )
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: appBarCategoriesVisibilityNotifier,
                            builder:
                                (context, appBarCategoriesVisibility, child) {
                              return Visibility(
                                visible: appBarCategoriesVisibility,
                                child: Row(
                                  //  appBar categories
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "TV Shows",
                                    ),
                                    Text("Movies"),
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: Text("Categories",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        label: Icon(Icons.arrow_drop_down,
                                            color: Colors.white))
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      // scroll up app bar container

                      width: MediaQuery.of(context).size.width,
                      height: 135,

                      child: Stack(
                        children: [
                          Visibility(
                            visible: upperGradVisibility,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ])),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                    child: Image.asset(
                                      "assets/netflix_logo.png",
                                      height: 45,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 15, 0),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search),
                                      iconSize: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 25, 0),
                                    child: Image(
                                      image: AssetImage("assets/user_dp.png"),
                                      height: 35,
                                    ),
                                  )
                                ],
                              ),
                              ValueListenableBuilder(
                                valueListenable:
                                    appBarCategoriesVisibilityNotifier,
                                builder: (context, appBarCategoriesVisibility,
                                    child) {
                                  return Visibility(
                                    visible: appBarCategoriesVisibility,
                                    child: Row(
                                      //  appBar categories
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("TV Shows"),
                                        Text("Movies"),
                                        TextButton.icon(
                                            onPressed: () {},
                                            icon: Text("Categories",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            label: Icon(Icons.arrow_drop_down,
                                                color: Colors.white))
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }

  double getScrollControllerOffset() {
    return scrollController.offset;
  }
}
