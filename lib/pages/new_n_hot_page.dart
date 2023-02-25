import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/pages/common.dart';

class NewNHotPage extends StatelessWidget {
  const NewNHotPage({super.key});

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
            IconButton(onPressed: () {}, icon: Icon(Icons.doorbell)),
            Image.asset(
              "assets/user_dp.png",
              width: 30,
            ),
            SizedBox(width: 10)
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
          comingSoon(),
          everyoneWatching(),
        ]),
      ),
    );
  }

  comingSoon() {
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
          itemCount: 10,
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
                        monthFromDate(upcomingMovies[index]['release_date']),
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        dayFromDate(upcomingMovies[index]['release_date']),
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
                                    "$baseImageUrl${upcomingMovies[index]['backdrop_path']}"),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .75,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                          upcomingMovies[index]['original_title'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text(upcomingMovies[index]['overview'])),
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

  everyoneWatching() {
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
          itemCount: 3,
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
                        monthFromDate(trendingMovies[index]['release_date']),
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        dayFromDate(trendingMovies[index]['release_date']),
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
                                    "$baseImageUrl${trendingMovies[index]['backdrop_path']}"),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .75,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                          trendingMovies[index]['original_title'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text(trendingMovies[index]['overview'])),
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

  String dayFromDate(String releaseDate) {
    List date = releaseDate.split("-");
    return date[2];
  }

  String monthFromDate(String releaseDate) {
    List date = releaseDate.split("-");
    String month = "";
    switch (date[1]) {
      case "01":
        month = "Jan";
        break;
      case "02":
        month = "Feb";
        break;
      case "03":
        month = "Mar";
        break;
      case "04":
        month = "Apr";
        break;
      case "05":
        month = "May";
        break;
      case "06":
        month = "Jun";
        break;
      case "07":
        month = "July";
        break;
      case "08":
        month = "Aug";
        break;
      case "09":
        month = "Sep";
        break;
      case "10":
        month = "Oct";
        break;
      case "11":
        month = "Nov";
        break;
      case "12":
        month = "Dec";
        break;
      default:
        month = "nill";
    }
    return month;
  }
}
