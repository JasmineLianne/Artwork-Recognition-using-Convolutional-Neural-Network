import '/ui/pages/explore_page.dart';
import '/ui/pages/home_page.dart';
import '/ui/pages/identify_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key : key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigateBottombar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget>_pages = [
    HomePage(),
    IdentifyPage(),
    ExplorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottombar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Identify Artwork'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore with AR'),

        ],
      ),
    );
  }
}
