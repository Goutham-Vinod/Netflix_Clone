import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/common/common_variables.dart';
import 'package:netflix_clone/screens/search_screen.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            //Row 1
            children: [
              Text(
                "Downloads",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return SearchScreen();
                  }));
                },
                icon: Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
              SizedBox(width: 20),
              Image.asset(
                "assets/user_dp.png",
                width: 40,
              ),
              SizedBox(width: 15)
            ],
          ),
          SizedBox(height: 30),
          //Row 2
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(Icons.settings),
              Text("  Smart Downloads"),
            ],
          ),
          SizedBox(height: 70),
          //Row 3
          Row(
            children: [
              Text(
                "Introducing Downloads for You",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 20),
          //Row 4
          Row(
            children: [
              Text("""We'll download a personalised selection of movies 
and shows for you,so there's always something to 
watch on your phone."""),
            ],
          ),
          SizedBox(height: 25),
          //Row 5

          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 110,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  child: Transform.rotate(
                    angle: 120,
                    child: Container(
                      width: 130,
                      height: 160,
                      // color: Colors.blue,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$baseImageUrl${randomObj?.results[2].posterPath}"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: Transform.rotate(
                    angle: 100,
                    child: Container(
                      width: 130,
                      height: 160,
                      // color: Colors.blue,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$baseImageUrl${randomObj?.results[1].posterPath}"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 125,
                  child: Container(
                    width: 130,
                    height: 180,
                    // color: Color.fromARGB(255, 33, 243, 110),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                                "$baseImageUrl${randomObj?.results[0].posterPath}"),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),
          //Row 6
          SizedBox(
              width: 400,
              child: ElevatedButton(onPressed: () {}, child: Text("Set Up"))),
          SizedBox(height: 25),
          //Row 7
          ElevatedButton(
            onPressed: () {},
            child: Text("Find More to Download"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 72, 72, 72))),
          )
        ],
      ),
    );
  }
}
