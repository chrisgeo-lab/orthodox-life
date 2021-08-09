import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthodox_app/globals.dart';
import 'package:orthodox_app/pages/home.dart';
import 'package:orthodox_app/pages/readings.dart';
import 'package:orthodox_app/pages/prayer_book.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    PrayerBook(),
    Readings(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Orthodox Life",
          style: GoogleFonts.getFont(
            'Bentham',
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              backgroundLightColor,
              backgroundDarkColor,
            ],
          ),
        ),
        child: _children[_currentIndex]
      ), // new
      bottomNavigationBar: BottomNavBar(onTabTapped,_currentIndex),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(this.onTabTapped, this.currentIndex, {Key? key}) : super(key: key);

  final void Function(int) onTabTapped;
  final int currentIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      backgroundColor: navColor,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      onTap: widget.onTabTapped, // new
      currentIndex: widget.currentIndex, // new
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Prayer Book',
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Readings',
        ),
      ],
    );
  }
}



