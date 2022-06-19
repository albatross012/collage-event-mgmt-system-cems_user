import 'package:cems/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    UserHome(),
    UserProfile(),
    Text(
      'Index 2: History',
      style: optionStyle,
    ),
    Text(
      'ACHIEVEMENTS',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
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
        appBar: AppBar(
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
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.badge), label: 'ACHIEVEMENTS'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
