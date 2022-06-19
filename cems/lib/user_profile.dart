import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/user%20icon.png?alt=media&token=735900ed-ae5a-4d42-bbbc-8655cb9b6d14";
  changeImage() {
    setState(() {
      imageUrl =
          "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot.com/o/art.jpg?alt=media&token=7d6cc0bd-891b-462b-8bdf-4eaf2e009097";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
      padding: const EdgeInsets.all(10),
      width: 400,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Center(
              child: SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    Positioned(
                        bottom: 0,
                        right: -25,
                        child: RawMaterialButton(
                          onPressed: () {
                            changeImage();
                          },
                          elevation: 2.0,
                          fillColor: const Color(0xFFF5F6F9),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ))));
  }
}
