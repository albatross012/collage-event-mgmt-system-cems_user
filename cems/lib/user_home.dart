import 'dart:convert';
import 'dart:developer';

import 'package:cems/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<Feeds> feeds = [];
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  Future<bool> getFeeds() async {
    try {
      var url = Uri.parse('$releaseUrl/feeds/getfeeds');
      var response = await http.get(
        url,
      );

      log('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          feeds = jsonDecode(response.body)["events"]
              .map<Feeds>((e) => Feeds.fromJson(e))
              .toList();
          feeds = feeds.reversed.toList();
        });
        return true;
      } else {
        log("Somthing went wrong");
        return false;
      }
    } catch (e) {
      log("Error occured in events -->$e");
      return false;
    }
  }

  @override
  void initState() {
    getFeeds().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          SingleChildScrollView(
            child: SizedBox(
              height: 80,
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
                    color:
                        const Color(0xff36CDC6).withOpacity((index + 1) / 10),
                  ),
                  height: 80,
                  width: 100,
                  child: Center(
                    child: Text("Shortcut ${index + 1}"),
                  ),
                ),
                itemCount: 5,
              ),
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
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 200),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, -1),
                        color: Colors.black.withAlpha(40),
                      )
                    ],
                    borderRadius: BorderRadiusDirectional.circular(
                      28,
                    ),
                  ),
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageSlideshow(
                          width: double.infinity,
                          height: 300,
                          initialPage: 0,
                          indicatorColor: Colors.blue,
                          indicatorBackgroundColor: Colors.grey,
                          children: feeds[index]
                              .imageUrl
                              .map((e) => Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(e),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: feeds.length,
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
      ),
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

class Feeds {
  final List<String> imageUrl;

  const Feeds({required this.imageUrl});

  factory Feeds.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Feeds(
      imageUrl: json['imageUrl'].map<String>((e) => e.toString()).toList(),
    );
  }
}
