import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/numbered_showcase.dart';
import 'package:netflix_clone/pages/common.dart';
import 'package:netflix_clone/showcase.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int appBarOpacy = 0; //255 max and 0 min
  ValueNotifier<bool> appBarVisibilityNotifier = ValueNotifier(false);
  final ScrollController scrollController = ScrollController();
  ValueNotifier<bool> appBarCategoriesVisibilityNotifier = ValueNotifier(true);
  bool upperGradVisibility = false;

  loadMovies() async {
    final trendingMoviesResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey"));
    Map trendingMoviesResults = json.decode(trendingMoviesResponse.body);

    final topRatedTvShowsResponse = await http.get(
        Uri.parse("https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey"));
    Map topRatedTvShowsResults = json.decode(topRatedTvShowsResponse.body);

    final popularTvShowsResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&language=en-US&page=1"));
    Map popularTvShowsResults = json.decode(popularTvShowsResponse.body);

    final upcomingMoviesResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1"));
    Map upcomingMoviesResults = json.decode(upcomingMoviesResponse.body);

    final topRatedMoviesResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1"));
    Map topRatedMoviesResults = json.decode(topRatedMoviesResponse.body);

    final popularMoviesResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1"));
    Map popularMoviesResults = json.decode(popularMoviesResponse.body);

    final nowPlayingMoviesResponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1"));
    Map nowPlayingMoviesResults = json.decode(nowPlayingMoviesResponse.body);

    try {
      setState(() {
        trendingMovies = trendingMoviesResults['results'];
        topRatedTvShows = topRatedTvShowsResults['results'];
        popularTvShows = popularTvShowsResults['results'];
        upcomingMovies = upcomingMoviesResults['results'];
        topRatedMovies = topRatedMoviesResults['results'];
        popularMovies = popularMoviesResults['results'];
        nowPlayingMovies = nowPlayingMoviesResults['results'];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    setState(() {
      loadMovies();
    });
    super.initState();
  }

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
                    Showcase(
                        title: "Trending Movies",
                        showcaseContent: trendingMovies),
                    Showcase(
                        title: "Popular Movies",
                        showcaseContent: popularMovies),
                    NumberedShowcase(
                        title: "Top Rated Movies",
                        showcaseContent: topRatedMovies),
                    Showcase(
                        title: "Popular TV Shows",
                        showcaseContent: popularTvShows),
                    Showcase(
                        title: "Upcoming Movies",
                        showcaseContent: upcomingMovies),
                    NumberedShowcase(
                        showcaseContent: topRatedTvShows,
                        title: "Top Rated TV Shows"),
                    Showcase(
                        title: "Now Playing Movies",
                        showcaseContent: nowPlayingMovies),
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
