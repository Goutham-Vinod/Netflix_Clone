import 'package:flutter/material.dart';

String kImageUrl =
    "https://static.theprint.in/wp-content/uploads/2022/07/stranger_things_main20220701132803.jpg";
String kImageUrl2 =
    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/luhKkdD80qe62fwop6sdrXK9jUT.jpg";

final String apiKey = "46b56132b1ed6ad76bc0ecbd2e7b0995";
const String baseUrl = "https://api.themoviedb.org/3/";
const String baseImageUrl = "https://image.tmdb.org/t/p/w500";

List trendingMovies = [];
List topRatedTvShows = [];
List popularTvShows = [];
List upcomingMovies = [];
List topRatedMovies = [];
List popularMovies = [];
List nowPlayingMovies = [];

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
