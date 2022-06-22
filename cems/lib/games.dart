import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Image(
            image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/games.png?alt=media&token=b511d263-5346-45f5-ab2e-7ed3e7c02704',
            ),
          )
        ],
      ),
    );
  }
}
