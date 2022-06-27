// // ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:demo1/games.dart';
// import 'package:demo1/techtalk.dart';
// import 'package:demo1/webinar.dart';
// import 'package:demo1/workshop.dart';
import 'dart:async';

import 'package:demo1/games.dart';
import 'package:demo1/techtalk.dart';
import 'package:demo1/webinar.dart';
import 'package:demo1/workshop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(home: Demo()));
// }

// class Demo extends StatefulWidget {
//   const Demo({Key? key}) : super(key: key);

//   @override
//   State<Demo> createState() => _DemoState();
// }

// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GridView(
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Workshop()),
//                 );
//               },
//               child: Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.all(8),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(28),
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Ink.image(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       'assets/img1.jpg',
//                     ),
//                     // child: InkWell(
//                     //   splashColor: Color.fromARGB(255, 195, 188, 188),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Games()),
//                 );
//               },
//               child: Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.all(8),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(28),
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Ink.image(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                       'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/games.png?alt=media&token=b511d263-5346-45f5-ab2e-7ed3e7c02704',
//                     ),
//                     // child: InkWell(
//                     //   splashColor: Color.fromARGB(255, 195, 188, 188),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Webinar()),
//                 );
//               },
//               child: Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.all(8),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(28),
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Ink.image(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       'assets/img1.jpg',
//                     ),
//                     // child: InkWell(
//                     //   splashColor: Color.fromARGB(255, 195, 188, 188),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Techtalk()),
//                 );
//               },
//               child: Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.all(8),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(28),
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Ink.image(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       'assets/img1.jpg',
//                     ),
//                     // child: InkWell(
//                     //   splashColor: Color.fromARGB(255, 195, 188, 188),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               color: Color.fromARGB(255, 74, 70, 70),
//               margin: EdgeInsets.all(8),
//             ),
//             Container(
//               color: Color.fromARGB(255, 85, 80, 80),
//               margin: EdgeInsets.all(8),
//             ),
//             Container(
//               color: Color.fromARGB(255, 81, 77, 77),
//               margin: EdgeInsets.all(8),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
void main() {
  runApp(MaterialApp(
    home: Demo(),
  ));
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
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
              width: 100,
              child: Center(child: Text(events[index]["title"].toString())),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      events[index]["url"].toString(),
                    ),
                    fit: BoxFit.cover),
                color: Colors.red,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<dynamic> events = [
  {
    "title": "Demo",
    "url": "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4?ixlib=rb-"
        "1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit="
        "crop&w=500&q=60"
  },
  {
    "title": "Games",
    "url": "https://images.unsplash.com/photo-1605559911160-a3d95d213904?ixlib=rb-1.2"
        ".1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=411&q=80"
  },
  {
    "title": "Webinar",
    "url": "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4?ixlib=rb-"
        "1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit="
        "crop&w=500&q=60"
  },
  {
    "title": "Workshop",
    "url": "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4?ixlib=rb-"
        "1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit="
        "crop&w=500&q=60"
  },
  {
    "title": "Tectlak",
    "url": "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4?ixlib=rb-"
        "1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit="
        "crop&w=500&q=60"
  }
];
route(int pageNumber, BuildContext context) {
  if (pageNumber == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Demo()),
    );
  }
  if (pageNumber == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Games()),
    );
  }
  if (pageNumber == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Webinar()),
    );
  }
  if (pageNumber == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Workshop()),
    );
  }
  if (pageNumber == 5) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Techtalk()),
    );
  }
}
