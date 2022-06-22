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
            image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354',
            ),
          )
        ],
      ),
    );
  }
}
