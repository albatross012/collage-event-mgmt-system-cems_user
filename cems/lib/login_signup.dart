// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:cems/bottom_nav.dart';
import 'package:cems/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_user.dart';
import 'package:http/http.dart' as http;

Future<User?> loginUser(
    String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('$releaseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'password': password, 'email': email}),
    );
    log(response.statusCode.toString());
    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login failed!!"),
          content: Text(jsonDecode(response.body)["message"]),
        ),
      );
      return null;
    } else {
      log("herer");
      const storage = FlutterSecureStorage();
      final user = User.fromJson(jsonDecode(response.body.toString()));
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'pass', value: user.passsword);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserNavigation(
            email: user.email,
          ),
        ),
      );
      return user;
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
}

class User {
  final String email;
  final String passsword;

  const User({required this.email, required this.passsword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json["user"]['email'], passsword: json["user"]['password']);
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool isCheking = true;
  bool isBusy = false;
  bool _isObscure = true;
  User? _futureUser;

  checkIfUserExist() async {
    const storage = FlutterSecureStorage();
    final String email = await storage.read(
          key: 'email',
        ) ??
        "";
    final String pass = await storage.read(
          key: 'pass',
        ) ??
        "";
    if (email.isNotEmpty && pass.isNotEmpty) {
      await loginUser(email, pass, context);
    } else {
      setState(() {
        isCheking = false;
      });
    }
  }

  @override
  void initState() {
    checkIfUserExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Color(0xff36CDC6),
                    // Color(0xff976FC4),
                    // Color(0xff8C70C6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.25,
                    .55,
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 400,
                          width: 400,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/logocms"
                                  "_page-0001__1_-removebg-preview.png?alt=media&token=4dca147d-8063-4642-84e9-002889f2514f"),
                            ),
                          ),
                        ),
                        Text(
                          "CEMS",
                          style: GoogleFonts.iceberg(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _emailcontroller,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(19),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(19),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    labelText: "username",
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    hintText: "email",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    fillColor: Colors.white30,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _passwordcontroller,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(19),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(19),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    labelText: "password",
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    hintText: "",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    fillColor: Colors.white30,
                                  ),
                                ),
                                SizedBox(
                                  height: 45 - 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: MaterialButton(
                                      minWidth: 152,
                                      height: 61,
                                      onPressed: () async {
                                        setState(() {
                                          isBusy = true;
                                        });
                                        await loginUser(
                                                _emailcontroller.text,
                                                _passwordcontroller.text,
                                                context)
                                            .then((value) {
                                          if (mounted) {
                                            setState(() {
                                              isBusy = false;
                                            });
                                          }
                                        });
                                        // setState(() {});
                                      },
                                      color: Colors.white30,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      // style: ButtonStyle(
                                      //   shape: MaterialStateProperty.all(
                                      //     RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(19.0),
                                      //         side: const BorderSide(
                                      //             color: Colors.white)),
                                      //   ),
                                      // ),
                                      child: const Text(
                                        "login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewUser()),
                                        );
                                      },
                                      child: const Text(
                                        "New user? Create",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isBusy)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white60,
                ),
                child: Center(
                  child: SpinKitCircle(
                    size: 60,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
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
                ),
              )
          ],
        ),
      ),
    );
  }
}
