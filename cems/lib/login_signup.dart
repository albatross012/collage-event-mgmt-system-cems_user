import 'dart:convert';
import 'dart:developer';
import 'package:cems/bottom_nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_user.dart';
import 'package:http/http.dart' as http;

Future<User?> loginUser(
    String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/users/login'),
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
          title: const Text("Backend Error!"),
          content: Text(jsonDecode(response.body)["message"]),
        ),
      );
      return null;
    } else {
      const storage = FlutterSecureStorage();
      final user = User.fromJson(jsonDecode(response.body.toString()));
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'pass', value: user.passsword);
      Navigator.pushReplacement(
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xffCD4EB9),
                  Color(0xff976FC4),
                  Color(0xff8C70C6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.25, .55, 0.9, 1],
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
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/icon_page-0001.png?alt=media&token=be2a6669-eda5-4c70-8105-4e332e4fd265",
                          height: 245,
                          width: 137,
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
                                obscureText: true,
                                decoration: InputDecoration(
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
                                      _futureUser = await loginUser(
                                          _emailcontroller.text,
                                          _passwordcontroller.text,
                                          context);
                                      setState(() {});
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
        ],
      ),
    );
  }
}
