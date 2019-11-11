import 'package:denphy_wallpapers/main_image_screen/fullscreen_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_indicators/progress_indicators.dart';

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => new _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
      Firestore.instance.collection("walls");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });

    // _currentScreen();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Recents",
            style: TextStyle(
                fontFamily: 'Welcome', color: Colors.blue, fontSize: 32.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: wallpapersList != null
            ? new StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: wallpapersList.length,
                itemBuilder: (context, i) {
                  String imgPath = wallpapersList[i].data['name1'];
                  String fullImageLink = wallpapersList[i].data['image_link'];
                  String imageName = wallpapersList[i].data['image_name'];
                  print(imgPath);
                  return new Material(
                    elevation: 8.0,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(8.0)),
                    child: new InkWell(
                      onTap: () {
                        print(imageName);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new FullScreenImagePage(fullImageLink,imageName)));
                      },
                      child: new Hero(
                        tag: imgPath,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: new FadeInImage(
                            image: new NetworkImage(imgPath),
                            fit: BoxFit.cover,
                            placeholder:
                                new AssetImage("assets/images/splash_icon.png"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (i) =>
                    new StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }
}
