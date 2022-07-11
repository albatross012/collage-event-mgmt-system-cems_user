// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 15,
        //     vertical: 5,
        //   ),
        //   // child: TextField(
        //   //   decoration: InputDecoration(
        //   //     hintText: "CEMS",
        //   //     hintStyle: GoogleFonts.roboto(
        //   //       color: Colors.grey,
        //   //       fontSize: 13,
        //   //       fontWeight: FontWeight.w400,
        //   //     ),
        //   //     enabledBorder: OutlineInputBorder(
        //   //       borderRadius: BorderRadius.circular(18),
        //   //       borderSide: BorderSide(
        //   //         color: Colors.grey.withOpacity(0.5),
        //   //       ),
        //   //     ),
        //   //   ),
        //   // ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Quick Acess",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 15 : 8,
                right: 8,
                top: 8,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xff36CDC6).withOpacity((index + 1) / 10),
              ),
              height: 100,
              width: 100,
              child: Center(
                child: Text("Shortcut ${index + 1}"),
              ),
            ),
            itemCount: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEEDS",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 765,
          child: Material(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, -1),
                      color: Colors.black.withAlpha(40),
                    )
                  ],
                  borderRadius: BorderRadiusDirectional.circular(
                    28,
                  ),
                ),
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      child: ImageSlideshow(
                          width: double.infinity,
                          height: 200,
                          initialPage: 0,
                          indicatorColor: Colors.blue,
                          indicatorBackgroundColor: Colors.grey,
                          children: [
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/WhatsApp%20Image%202022-07-11%20at%209.40.54%20PM.jpeg?alt=media&token=225d5a0d-caa7-424e-8643-227c1cc04349'),
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/WhatsApp%20Image%202022-07-11%20at%209.38.59%20PM.jpeg?alt=media&token=ef906b64-b071-48e7-be3d-a684f4e0065d'),
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/splash.jpg?alt=media&token=570ebe82-7f77-469a-88e5-cdeb5943be52'),
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/WhatsApp%20Image%202022-07-11%20at%209.40.57%20PM.jpeg?alt=media&token=c80a9ff8-4b49-4180-9e1f-023ec0686086'),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Thandav",
                        style: GoogleFonts.roboto(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "descriptin of the event dsjkfvnjsfdvnjsfdvbkfshv vf v vi v sui vhusfi hui uiv h uiv huivshui huivsh suiuiv huihv s",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text("Read More >>")),
                  ],
                ),
              ),
              itemCount: 10,
            ),
          ),
          // child: ListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   itemBuilder: (context, index) => Container(
          //     margin: EdgeInsets.only(
          //       left: index == 0 ? 15 : 8,
          //       right: 8,
          //       top: 8,
          //       bottom: 8,
          //     ),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(18),
          //       color: const Color.fromARGB(255, 90, 68, 188)
          //           .withOpacity((index + 1) / 10),
          //     ),
          //     height: 100,
          //     child: Row(),
          //   ),
          //   itemCount: 3,
          // ),
        )
      ],
    );
  }
}

Widget gridCreate(BuildContext context,
    {required IconData icon, required String label, required Widget page}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 75,
            color: Color.fromARGB(255, 36, 188, 10),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ],
      ),
    ),
  );
}
