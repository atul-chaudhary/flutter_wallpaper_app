import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'dart:io' as Io;
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imgPath;
  final String imgName;

  FullScreenImagePage(this.imgPath, this.imgName);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  bool permission = false;
  bool downloading = false;
  var progress = '';
  var _progresss;
  String _batteryLevel = 'Unknown battery level.';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPermission();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progresss = progress;
        print('>>>>>>>>>>>>>>>>>>$_progresss');
      });
    });
  }

  final LinearGradient backgroundGradient = new LinearGradient(
      colors: [new Color(0x10000000), new Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  void toastFunction(context, message) {
    //Toast.show("Double Tap to Zoom",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  IconData changeIcon() {
    if (_progresss == 100) {
      setState(() {
        return Icons.done;
      });
    } else {
      setState(() {
        return Icons.arrow_downward;
      });
    }
    return Icons.arrow_downward;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //toastFunction(context, 'Double tap to Zoom');

    return new Scaffold(
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backgroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: PhotoView.customChild(
                  child: CachedNetworkImage(
                    imageUrl: widget.imgPath,
                    placeholder: (context, url) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //loadingChild: CircularProgressIndicator(),
                  childSize: Size(width, height),
                  //initialScale: PhotoViewComputedScale.covered*height,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.imgPath),
                  //initialScale: height,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: new Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    toastFunction(context, 'Image Downloading In Background');
                    var imageId = await ImageDownloader.downloadImage(
                      widget.imgPath,
                      destination: AndroidDestinationType.custom()
                        ..subDirectory("denphy walls/${widget.imgName}.jpg"),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: new Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: Icon(
                        (_progresss != 100) ? Icons.arrow_downward : Icons.done,
                        color: Colors.white,
                      ),
                    )),
              ),
              new Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    setWallpaperDialog();
                    ///_getBatteryLevel();
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //function for the setting wallpaper in android;
  void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Set a wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(1),
              ),
              ListTile(
                title: Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(2),
              ),
              ListTile(
                title: Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(3),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _setWallpaper(int wallpaperType) async {
    var file =
        await DefaultCacheManager().getSingleFile(widget.imgPath);
    try {
      final int result = await platform
          .invokeMethod('setWallpaper',{"path":file.path,"type":wallpaperType});
      print('Wallpaer Updated.... $result');
    } on PlatformException catch (e) {
      print("Failed to Set Wallpaer: '${e.message}'.");
    }
    Fluttertoast.showToast(
        msg: "Wallpaper set successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
    Navigator.pop(context);
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel',{"path":"fuck bo"});
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<>$_batteryLevel');
    });
  }
}
