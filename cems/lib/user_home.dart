// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'new_user.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 180, childAspectRatio: 1),
        children: [
          gridCreate(context,
              icon: Icons.home, label: "HOME", page: UserHome()),
          gridCreate(context,
              icon: Icons.edit, label: "EDIT", page: UserHome()),
          gridCreate(context,
              icon: Icons.settings, label: "SETTINGS", page: UserHome())
        ],
      ),
    );
  }
}

Widget gridCreate(BuildContext context,
    {required IconData icon, required String label, required Widget page}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 75,
            color: Color.fromARGB(255, 36, 188, 10),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ],
      ),
    ),
  );
}
