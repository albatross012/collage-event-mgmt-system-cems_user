import 'package:flutter/material.dart';

class Techtalk extends StatefulWidget {
  const Techtalk({Key? key}) : super(key: key);

  @override
  State<Techtalk> createState() => _TechtalkState();
}

class _TechtalkState extends State<Techtalk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Image(
            image: AssetImage(
              'assets/img1.jpg',
            ),
          )
        ],
      ),
    );
  }
}
