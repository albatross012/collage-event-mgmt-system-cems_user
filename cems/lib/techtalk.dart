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
              'firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/techtalks.jpg?alt=media&token=02683e3c-0ecc-49fe-9355-971c6d006b12',
            ),
          )
        ],
      ),
    );
  }
}
