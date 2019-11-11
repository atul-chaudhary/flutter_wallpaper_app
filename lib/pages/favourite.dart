import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  static final String id='favourite';
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
