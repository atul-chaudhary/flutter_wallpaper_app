import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/material.dart';
import './home.dart';
import './favourite.dart';
import './category.dart';
import './downloads.dart';

class HomePage extends StatefulWidget {
  static final String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndexNav = 0;
  final _pageSelected = [
    Home(),
    Favourite(),
    Category(),
    Downloads(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageSelected[currentIndexNav],
      bottomNavigationBar: bmnav.BottomNav(

        onTap: (index) => {
          setState(() {
            currentIndexNav = index;
          })
        },
        items: [
          bmnav.BottomNavItem(Icons.home),
          bmnav.BottomNavItem(Icons.favorite),
          bmnav.BottomNavItem(Icons.category),
          bmnav.BottomNavItem(Icons.arrow_downward)
        ],
      ),
    );
  }
}
