import 'package:denphy_wallpapers/pages/category.dart';
import 'package:denphy_wallpapers/pages/downloads.dart';
import 'package:denphy_wallpapers/pages/favourite.dart';
import 'package:denphy_wallpapers/pages/home.dart';
import 'package:denphy_wallpapers/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage()
    ),
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
}
