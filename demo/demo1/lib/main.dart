// ignore_for_file: prefer_const_constructors

import 'package:demo1/games.dart';
import 'package:demo1/techtalk.dart';
import 'package:demo1/webinar.dart';
import 'package:demo1/workshop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Demo()));
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Workshop()),
                );
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/img1.jpg',
                    ),
                    // child: InkWell(
                    //   splashColor: Color.fromARGB(255, 195, 188, 188),
                    // ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Games()),
                );
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/img1.jpg',
                    ),
                    // child: InkWell(
                    //   splashColor: Color.fromARGB(255, 195, 188, 188),
                    // ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Webinar()),
                );
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/img1.jpg',
                    ),
                    // child: InkWell(
                    //   splashColor: Color.fromARGB(255, 195, 188, 188),
                    // ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Techtalk()),
                );
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/img1.jpg',
                    ),
                    // child: InkWell(
                    //   splashColor: Color.fromARGB(255, 195, 188, 188),
                    // ),
                  ),
                ),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 74, 70, 70),
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Color.fromARGB(255, 85, 80, 80),
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Color.fromARGB(255, 81, 77, 77),
              margin: EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );
  }
}
