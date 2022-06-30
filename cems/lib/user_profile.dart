import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cems/main.dart';
import 'package:cems/new_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final storage = const FlutterSecureStorage();
  User? user;
  Future<User?> getUserData() async {
    try {
      final String? token = await storage.read(key: 'token');
      final String? userid = await storage.read(key: 'email');
      var url = Uri.parse('$releaseUrl/users/username');
      log(token.toString());
      var response = await http.post(url,
          headers: {'Authorization': 'Bearer $token'},
          body: {'username': userid});
      log('Response status: ${response.statusCode}}');
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        log("Somthing went wrong");
        return null;
      }
    } catch (e) {
      log("Error occured in login -->$e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LinearProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xff36CDC6),
                      // backgroundImage: NetworkImage(user.imageUrl.toString()),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  detailsBox(
                    heading: "Basic Details",
                    onTap: () {},
                    children: [
                      detailsRow(
                          key: "Name        ",
                          value:
                              "${snapshot.data?.firstname} ${snapshot.data?.lastname}"),
                      detailsRow(
                          key: "Email       ", value: snapshot.data?.email),
                      detailsRow(
                          key: "Phone Number",
                          value: snapshot.data?.phoneNumber),
                      detailsRow(
                          key: "College Name",
                          value: snapshot.data?.collegeName),
                      detailsRow(
                          key: "DeptName    ", value: snapshot.data?.deptName),
                    ],
                  ),
                  detailsBox(
                      heading: "Additional Details",
                      onTap: () {},
                      children: [
                        detailsRow(key: "Year of Joining", value: ""),
                        detailsRow(key: "Admission no", value: ""),
                        detailsRow(key: "", value: ""),
                      ]),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: MaterialButton(
                        focusElevation: 0,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: const Color(0xff36CDC6),
                        minWidth: 150.0,
                        onPressed: () async {
                          await storage.deleteAll();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Logout",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget detailsBox({
  required String heading,
  required Function onTap,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 30,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 12,
          spreadRadius: 5,
          color: Colors.black.withAlpha(20),
        )
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    heading,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xff36CDC6),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
          ...children
        ],
      ),
    ),
  );
}

Widget detailsRow({
  String? key,
  String? value,
  double padding = 5,
}) {
  return Container(
    padding: EdgeInsets.all(padding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key!,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          value.toString(),
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
  );
}
