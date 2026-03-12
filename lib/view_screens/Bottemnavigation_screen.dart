import 'package:arrive_app/Settings_page/Setting_screen.dart';
import 'package:arrive_app/inspiration/inspiration_feed.dart';
import 'package:arrive_app/view_screens/Getstarted_screen.dart';
import 'package:flutter/material.dart';

// 🔹 IMPORT YOUR ALREADY CREATED SCREENS
import 'home_screen.dart';


class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  int _currentIndex = 0;

  // 🔥 CALL YOUR EXISTING SCREENS HERE
  final List<Widget> _screens = [
    const HomeScreen(),
    GetStartedScreen(),
    const InspirationFeed(),
    Settings1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff98FF98),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // 🔥 important for 4 items
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Music",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Journal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
