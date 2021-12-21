import 'package:flutter/material.dart';
import 'package:instagram/Screens/account.dart';
import 'package:instagram/Screens/home.dart';
import 'package:instagram/Screens/reals.dart';
import 'package:instagram/Screens/search.dart';
import 'package:instagram/Screens/shop.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> body = [
    Home(),
    Search(),
    Reals(),
    Shop(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_front), label: "reals"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: "shop"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "account"),
        ],
      ),
    );
  }
}
