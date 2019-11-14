import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:denphy_wallpapers/main_image_screen/fullscreen_wallpaper.dart';

class Downloads extends StatefulWidget {
  static final String id = 'downloads';

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  List images;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Downloads",
          style: TextStyle(
              fontFamily: 'Welcome', color: Colors.blue, fontSize: 32.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: images != null
          ? new StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        itemCount: images.length,
        itemBuilder: (context, i) {
          //Random random=new Random();
          //var r=0+random.nextInt(wallpapersList.length);
          String imgPath = images[i];
          print(imgPath);
          //ImageProvider imageProvider = MemoryImage(loa)
          return new Material(
            elevation: 8.0,
            borderRadius:
            new BorderRadius.all(new Radius.circular(8.0)),
            child: new InkWell(
              onTap: () {
                //print(imageName);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new FullScreenImagePage(imgPath,"")));
              },
              child: new Hero(
                tag: imgPath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(File(imgPath),fit: BoxFit.cover,)
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
      ),
    );
  }

  //Check the MainActivity.java
  Future<void> _getImages() async {
    print('inside get images>>>>>>>>>>>>');
    List imgs;
    try {
      final List result = await platform.invokeMethod('getImages');
      imgs = result;
      for (String i in result) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$i');
      }
    } on PlatformException catch (e) {
      print("Error");
    }

    setState(() {
      images = imgs;
    });
  }

  String lastitemRemover(String str){

//    if (str != null && str.length > 0 && str.charAt(str.length - 1) == 'x') {
//      str = str.substring(0, str.length - 1);
//    }
//    return str;

  }

}
