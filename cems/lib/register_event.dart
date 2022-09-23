import 'dart:convert';
import 'dart:developer';
import 'package:cems/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<Register?> createRegister(
    String username, String id, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('$releaseUrl/register/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'id': id,
      }),
    );
    log(response.statusCode.toString());
    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Alert"),
          content: Text(jsonDecode(response.body)["message"]),
        ),
      );
      return null;
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Registeration Sucessful!"),
          content: Text("You have Successfully registered"),
        ),
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error!"),
        content: Text(e.toString()),
      ),
    );
    return null;
  }
  return null;
}

class Register {
  final String username;
  final String id;

  const Register({
    required this.username,
    required this.id,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Register(username: json['username'], id: json['id']);
  }
}

class RegisterEvent extends StatefulWidget {
  final String email;
  const RegisterEvent({Key? key, required this.email}) : super(key: key);

  @override
  State<RegisterEvent> createState() => _RegisterEventState();
}

class _RegisterEventState extends State<RegisterEvent> {
  List<Event> events = [];

  bool isLoading = true;
  bool isBusy = false;
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
      body: isLoading || isBusy
          ? Center(
              child: SpinKitCircle(
                size: 80,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.9),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index.isEven
                            ? const Color(0xff36CDC6)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  );
                },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageSlideshow(
                                  width: double.infinity,
                                  height: 500,
                                  initialPage: 0,
                                  indicatorColor: Colors.blue,
                                  indicatorBackgroundColor: Colors.grey,
                                  children: events[index]
                                      .imageUrl
                                      .map(
                                        (e) => Container(
                                          height: 500,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(e),
                                            ),
                                          ),
                                        ),
                                      )
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
                                    onPressed: () async {
                                      setState(() {
                                        isBusy = false;
                                      });
                                      await createRegister(widget.email,
                                              events[index].id, context)
                                          .then((value) {
                                        if (mounted) {
                                          setState(() {
                                            isBusy = false;
                                          });
                                        }
                                      });
                                    },
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
  final String id;
  const Event(
      {required this.eventName,
      required this.description,
      required this.imageUrl,
      required this.id});

  factory Event.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Event(
      id: json['_id'],
      eventName: json['eventName'],
      description: json['description'],
      imageUrl: json['imageUrl'].map<String>((e) => e.toString()).toList(),
    );
  }
}
