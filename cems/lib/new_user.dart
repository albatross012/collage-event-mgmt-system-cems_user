import 'dart:convert';
import 'dart:developer';
import 'package:cems/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'bottom_nav.dart';

Future<String?> uploadImageAndGetUrl() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    File file = File(image.path);
    final ref = FirebaseStorage.instance
        .ref('/profile_images/${DateTime.now().millisecondsSinceEpoch}');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    log("her");
    final url = await ref.putFile(File(file.path), metadata).then((p0) async {
      log("herer");
      return (await p0.ref.getDownloadURL());
    });
    log(url);
    return url;
  }
  return null;
}

Future<User?> createUser(
    String username,
    String firstName,
    String lastname,
    String email,
    String password,
    String phoneNumber,
    String collegeName,
    String deptName,
    String imageUrl,
    BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('$releaseUrl/users/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'firstName': firstName,
        'lastName': lastname,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'deptName': deptName,
        'collegeName': collegeName,
        'profilePic': imageUrl
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
      await storage.write(
          key: 'token', value: jsonDecode(response.body.toString())["token"]);
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
  final String? phoneNumber;
  final String? collegeName;
  final String? deptName;
  final String? imageUrl;

  const User(
      {required this.username,
      required this.email,
      required this.lastname,
      required this.firstname,
      required this.passsword,
      required this.phoneNumber,
      required this.collegeName,
      required this.deptName,
      required this.imageUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return User(
        username: json["userdata"]['username'],
        email: json["userdata"]['email'],
        lastname: json["userdata"]['lastName'],
        firstname: json["userdata"]['firstName'],
        passsword: json["userdata"]['password'],
        phoneNumber: json["userdata"]['phoneNumber'],
        collegeName: json["userdata"]['collegeName'],
        deptName: json['userdata']['deptName'],
        imageUrl: json['userdata']['profilePic']);
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
  final TextEditingController _collegenameController = TextEditingController();

  final TextEditingController _deptnameController = TextEditingController();

  final TextEditingController _phnoController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  User? _futureUser;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    const title = Text(
      "NEW USER",
      style: TextStyle(color: Colors.white),
    );
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('NEW USER'),
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        // ),
        // extendBodyBehindAppBar: true,
        body: Stack(
      children: [
        Container(
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Colors.white,
          //       Color.fromARGB(255, 54, 140, 205),
          //       // Color(0xff976FC4),
          //       // Color(0xff8C70C6),
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     stops: [
          //       0.0,
          //       .55,
          //     ],
          //     tileMode: TileMode.repeated,
          //   ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : CustomScrollView(
                    slivers: [
                      const SliverAppBar(
                        iconTheme: IconThemeData(color: Colors.white),
                        elevation: 0,
                        backgroundColor: Color(0xff36CDC6),
                        // Provide a standard title.
                        title: title,
                        // Allows the user to reveal the app bar if they begin scrolling
                        // back up the list of items.
                        floating: true,
                        // Display a placeholder widget to visualize the shrinking size.

                        // Make the initial height of the SliverAppBar larger than normal.
                        expandedHeight: 65,
                      ),
                      SliverToBoxAdapter(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 80,
                                          backgroundColor:
                                              const Color(0xff36CDC6),
                                          backgroundImage: imageUrl == null
                                              ? null
                                              : NetworkImage(
                                                  imageUrl.toString()),
                                          child: imageUrl == null
                                              ? const Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                  size: 60,
                                                )
                                              : null,
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 40,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 205, 234, 232),
                                            child: IconButton(
                                              onPressed: () async {
                                                await uploadImageAndGetUrl()
                                                    .then((value) {
                                                  log(value.toString());
                                                  setState(() {
                                                    imageUrl = value;
                                                  });
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                textfield("FIRST NAME", "firstname",
                                    _firstnameController, false),
                                textfield("LAST NAME", "lastname",
                                    _lastnameController, false),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                                    decoration: InputDecoration(
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(19),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(19),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      labelText: "EMAIL",
                                      labelStyle: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      hintText: "username",
                                      hintStyle: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      fillColor: Colors.white30,
                                    ),
                                  ),
                                ),
                                textfield("PASSWORD", "eg:Password@123",
                                    _passwordController, true),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: TextFormField(
                                    controller: _confirmpasswordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      bool passwordValid =
                                          _passwordController.text ==
                                              _confirmpasswordController.text;
                                      if (!passwordValid) {
                                        return 'password must be the same';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(19),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(19),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      labelText: "CONFIRM PASSWORD",
                                      labelStyle: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      hintText: "",
                                      hintStyle: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      fillColor: Colors.white30,
                                    ),
                                  ),
                                ),
                                textfield("College Name", '',
                                    _collegenameController, false),
                                textfield(
                                    "DeptName", "", _deptnameController, false),
                                textfield(
                                    "Phone no", "", _phnoController, false),
                                const SizedBox(
                                  height: 45 - 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Center(
                                    child: MaterialButton(
                                      minWidth: 152,
                                      height: 61,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await createUser(
                                                  _emailController.text,
                                                  _firstnameController.text,
                                                  _lastnameController.text,
                                                  _emailController.text,
                                                  _passwordController.text,
                                                  _phnoController.text,
                                                  _collegenameController.text,
                                                  _deptnameController.text,
                                                  imageUrl ?? "",
                                                  context)
                                              .then((value) {
                                            if (mounted) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const CupertinoAlertDialog(
                                                    content:
                                                        Text("Invalid Values."),
                                                  ));
                                        }
                                      },

                                      color: Color(0xff36CDC6),
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
                                        "CREATE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_futureUser != null)
                                  const Text("login successful")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    ));
  }
}

Widget textfield(
    String label, String hint, TextEditingController _controller, bool value) {
  return Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: TextField(
      controller: _controller,
      obscureText: value,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        hintText: hint,
        hintStyle: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        fillColor: Colors.white30,
      ),
    ),
  );
}
