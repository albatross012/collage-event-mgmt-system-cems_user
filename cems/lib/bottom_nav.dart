import 'dart:developer';

import 'package:cems/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_event.dart';
import 'user_home.dart';
import 'user_profile.dart';

class UserNavigation extends StatefulWidget {
  final String email;
  const UserNavigation({Key? key, required this.email}) : super(key: key);
  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    UserHome(),
    Registerevent(),
    UserProfile(),
    Text(
      'Host',
      style: optionStyle,
    ),
    Text(
      'Results',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    log(index.toString());
    setState(() {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 10),
        curve: Curves.ease,
      );
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff36CDC6),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              const Color.fromARGB(255, 218, 236, 235),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserProfile()),
                              );
                            },
                            icon: Icon(
                              Icons.person,
                              color: Colors.lightBlue.shade400,
                            ),
                            iconSize: 50,
                          ),
                          // backgroundImage: NetworkImage(user.imageUrl.toString()),
                        ),
                        Text(
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            widget.email),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Events'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(title: const Text('mbits'))
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff36CDC6),
          title: Text('USER-${widget.email}'),
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
        body: Center(
          child: PageView(
            onPageChanged: ((value) {
              setState(() {
                _selectedIndex = value.toInt();
              });
            }),
            controller: _pageController,
            children: [..._widgetOptions],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Register',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Host',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.badge), label: 'Results')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff36CDC6),
          unselectedItemColor: const Color(0xff36CDC6),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
