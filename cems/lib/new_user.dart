import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bottom_nav.dart';

Future<User?> createUser(String username, String firstName, String lastname,
    String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/users/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'firstName': firstName,
        'lastName': lastname,
        'password': password,
        'email': email
      }),
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
      Navigator.popUntil(context, (route) => route.isFirst);
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
  final String username;
  final String email;
  final String lastname;
  final String firstname;
  final String passsword;

  const User(
      {required this.username,
      required this.email,
      required this.lastname,
      required this.firstname,
      required this.passsword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json["userdata"]['username'],
        email: json["userdata"]['email'],
        lastname: json["userdata"]['lastName'],
        firstname: json["userdata"]['firstName'],
        passsword: json["userdata"]['password']);
  }
}

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  User? _futureUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NEW USER'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                textfield(
                    "FIRST NAME", "firstname", _firstnameController, false),
                textfield("LAST NAME", "lastname", _lastnameController, false),
                // textfield("Email", "Enter valid email id as abc@gmail.com",
                //   _emailController, false),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value.toString());
                      if (!emailValid) {
                        return 'invalid mail';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: 'Enter valid email id as abc@gmail.com',
                      labelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
                textfield(
                    "PASSWORD", "eg:Password@123", _passwordController, true),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        _futureUser = await createUser(
                            _emailController.text,
                            _firstnameController.text,
                            _lastnameController.text,
                            _emailController.text,
                            _passwordController.text,
                            context);

                        setState(() {});
                        if (!isEmailVaid(_emailController.text)) {
                          showDialog(
                              context: context,
                              builder: (context) => const CupertinoAlertDialog(
                                    content: Text("Invalid Email."),
                                  ));
                        }
                      },
                      child: const Text(
                        "create",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                ),
                if (_futureUser != null) const Text("login successful")
              ],
            ),
          ),
        ));
  }
}

Widget textfield(
    String label, String hint, TextEditingController _controller, bool value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
      ),
      obscureText: value,
    ),
  );
}

bool isEmailVaid(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email.toString());
  if (!emailValid) {
    return false;
  } else {
    return true;
  }
}
