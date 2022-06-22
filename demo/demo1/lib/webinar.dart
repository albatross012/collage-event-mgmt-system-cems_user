import 'package:flutter/material.dart';

class Webinar extends StatefulWidget {
  const Webinar({Key? key}) : super(key: key);

  @override
  State<Webinar> createState() => _WebinarState();
}

class _WebinarState extends State<Webinar> {
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
