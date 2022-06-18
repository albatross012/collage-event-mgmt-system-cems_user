import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 231, 20, 199),
                //Color.fromARGB(255, 108, 114, 203),
              ],
            )),
          ),
          Column(
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
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(19)),
                              labelText: "username",
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
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(19)),
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
                                fillColor: Colors.transparent),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.transparent,
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Text(
                                  "login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
