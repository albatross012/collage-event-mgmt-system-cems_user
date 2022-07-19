import 'dart:convert';
import 'dart:developer';
import 'package:cems/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterEvent extends StatefulWidget {
  const RegisterEvent({Key? key}) : super(key: key);

  @override
  State<RegisterEvent> createState() => _RegisterEventState();
}

class _RegisterEventState extends State<RegisterEvent> {
  List<Event> events = [];
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  Future<bool> getEvents() async {
    try {
      var url = Uri.parse('$releaseUrl/events/getevents');
      var response = await http.get(
        url,
      );

      log('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          events = jsonDecode(response.body)["events"]
              .map<Event>((e) => Event.fromJson(e))
              .toList();
          events = events.reversed.toList();
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
    getEvents().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                color: Color(0xff36CDC6),
                radius: 40,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Material(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 200),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageSlideshow(
                                  width: double.infinity,
                                  height: 300,
                                  initialPage: 0,
                                  indicatorColor: Colors.blue,
                                  indicatorBackgroundColor: Colors.grey,
                                  children: events[index]
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    events[index].eventName.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    events[index].description.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    minWidth: 152,
                                    height: 61,
                                    color: const Color(0xff36CDC6),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    child: const Text(
                                      "REGISTER",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: events.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Event {
  final String description;
  final String eventName;
  final List<String> imageUrl;

  const Event(
      {required this.eventName,
      required this.description,
      required this.imageUrl});

  factory Event.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Event(
      eventName: json['eventName'],
      description: json['description'],
      imageUrl: json['imageUrl'].map<String>((e) => e.toString()).toList(),
    );
  }
}
