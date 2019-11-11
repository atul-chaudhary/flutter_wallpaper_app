import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:denphy_wallpapers/main_image_screen/fullscreen_wallpaper.dart';
import 'package:denphy_wallpapers/category_widget/category_images.dart';

class Category extends StatefulWidget {
  static final String id = 'category';

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Category',
            style: TextStyle(
                fontSize: 32.0, fontFamily: 'Welcome', color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('car')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/images/car.jpg'),
                    ),
                    Text(
                      'Cars',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('dark')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/images/dark.jpg'),
                    ),
                    Text(
                      'dark',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('city')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/images/city.jpg'),
                    ),
                    Text(
                      'City',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CategoryImages('landscape')));
                  },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/landscape.jpg')),
                    Text(
                      'Landscape',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('love')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/love.jpg')),
                    Text(
                      'Love',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('motivational')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/motivation.jpg')),
                    Text(
                      'Motivation',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('movies')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/movies.jpg')),
                    Text(
                      'Movies',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CategoryImages('mixed')));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/mixed.jpg')),
                    Text(
                      'Mixed',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'Welcome',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
