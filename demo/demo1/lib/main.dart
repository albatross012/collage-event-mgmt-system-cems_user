// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const Demo());
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(8),
            ),
          ],
        )),
      ),
    );
  }
}
