import 'dart:convert';
import 'dart:developer';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:cems/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

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

class Registered extends StatefulWidget {
  final String email;
  const Registered({Key? key, required this.email}) : super(key: key);

  @override
  State<Registered> createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  List<dynamic> registered = [];
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  Future<bool> getRegistered(String email, BuildContext context) async {
    try {
      log(email.toString());
      var url = Uri.parse('$releaseUrl/register/getuid');
      var response = await http.post(
        url,
        body: {
          'username': email,
        },
      );
      log('Response status: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          registered = jsonDecode(response.body)["events"];
          registered = registered.reversed.toList();
          log(registered.toString());
        });
        return true;
      } else {
        log("Somthing went wrong");
        return false;
      }
    } catch (e) {
      log("Error occured -->$e");
      return false;
    }
  }

  @override
  void initState() {
    getRegistered(widget.email, context).then((value) {
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
                                  children: registered[index]["imageUrl"]
                                      .map<Widget>(
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
                                  padding: const EdgeInsets.all(40.0),
                                  child: Center(
                                    child: Text(
                                      registered[index]["eventName"].toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff36CDC6)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: registered.length,
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
