import 'package:flutter/material.dart';

class Workshop extends StatefulWidget {
  const Workshop({Key? key}) : super(key: key);

  @override
  State<Workshop> createState() => _WorkshopState();
}

class _WorkshopState extends State<Workshop> {
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
