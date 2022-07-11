import 'package:cems/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Games extends StatefulWidget {
  // final String email;
  const Games({Key? key}) : super(key: key);
  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  List<dynamic> games = [
    {
      "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
          ".com/o/WhatsApp%20Image%202022-07-11%20at%207.29.09%20PM.jpeg?alt=media&token=f6a13242-3613-4386-a89f-9365fabc38cb",
      "title": "RANGAM",
      "desc": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"
          " specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially "
          "unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently"
          " with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    },
    {
      "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
          ".com/o/WhatsApp%20Image%202022-07-11%20at%207.29.10%20PM.jpeg?alt=media&token=952ae850-5419-4011-a4d0-670a7f2e5ffd",
      "title": "AGNI",
      "desc": "Inter college football and volleyball competition"
    },
    {
      "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
          ".com/o/WhatsApp%20Image%202022-07-11%20at%207.29.22%20PM.jpeg?alt=media&token=aa54c027-18f3-4237-94e3-de5f133d0949",
      "title": " battle ground",
      "desc": " wertygyugvyftyfvtyvy"
    },
    {
      "url": "https://firebasestorage.googleapis.com/v0/b/eventmanagement-7d33f.appspot"
          ".com/o/webinar.jpg?alt=media&token=e84ea3c4-8174-4d28-ab1f-4c503081e354",
      "title": " battle ground",
      "desc": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"
          " specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially "
          "unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently"
          " with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff36CDC6),
        // title: Text('USER-${widget.email}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              const storage = FlutterSecureStorage();
              await storage.deleteAll();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Material(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 200),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  games[index]["url"].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            games[index]["title"].toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            games[index]["desc"].toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Center(
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 152,
                            height: 61,
                            color: Color(0xff36CDC6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
