// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, -1),
                color: Colors.black.withAlpha(40),
              )
            ],
            borderRadius: BorderRadiusDirectional.circular(
              28,
            ),
          ),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.guim.co.uk/img/media/1bb31654c7ada0b32268489b347bbe9067c72fdc/164_256_3724_2234/master/3"
                          "724.jpg?width=1200&quality=85&auto=format&fit=max&s=edf0d8f3cdffbb5a6a3794bae33842a1"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  color: Colors.red,
                ),
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title $index",
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "descriptin of the event dsjkfvnjsfdvnjsfdvbkfshv vf v vi v sui vhusfi hui uiv h uiv huivshui huivsh suiuiv huihv s",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Read More >>")),
            ],
          ),
        ),
        itemCount: 10,
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
