//ignore_for_file: prefer_const_constructors

import 'package:cems/games.dart';
import 'package:cems/techtalk.dart';
import 'package:cems/webinar.dart';
import 'package:cems/workshop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Registerevent(),
  ));
}

class Registerevent extends StatefulWidget {
  const Registerevent({Key? key}) : super(key: key);

  @override
  State<Registerevent> createState() => _RegistereventState();
}

class _RegistereventState extends State<Registerevent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView.builder(
        itemCount: events.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              route(index + 1, context);
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    events[index]["url"].toString(),
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(18),
                color: Colors.deepPurple.shade300,
              ),
              child: Center(
                  child: Text(
                events[index]["title"].toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}

List<dynamic> events = [
  {
    "title": "Games",
    "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
        ".com/o/games.png?alt=media&token=b511d263-5346-45f5-ab2e-7ed3e7c02704"
  },
  {
    "title": "Webinar",
    "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
        ".com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354"
  },
  {
    "title": "Workshop",
    "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
        ".com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354"
  },
  {
    "title": "Tectlak",
    "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
        ".com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354"
  }
];
route(int pageNumber, BuildContext context) {
  if (pageNumber == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Games()),
    );
  }
  if (pageNumber == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Webinar()),
    );
  }
  if (pageNumber == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Workshop()),
    );
  }
  if (pageNumber == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Techtalk()),
    );
  }
}
