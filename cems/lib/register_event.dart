// ignore_for_file: prefer_const_constructors

import 'package:cems/games.dart';
import 'package:cems/techtalk.dart';
import 'package:cems/webinar.dart';
import 'package:cems/workshop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Registerevent()));
}

class Registerevent extends StatefulWidget {
  const Registerevent({Key? key}) : super(key: key);

  @override
  State<Registerevent> createState() => _RegistereventState();
}

class _RegistereventState extends State<Registerevent> {
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
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354',
                    ),
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
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/games.png?alt=media&token=b511d263-5346-45f5-ab2e-7ed3e7c02704',
                    ),
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
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354',
                    ),
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
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/techtalks.jpg?alt=media&token=02683e3c-0ecc-49fe-9355-971c6d006b12',
                    ),
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
