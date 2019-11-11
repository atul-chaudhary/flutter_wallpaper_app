import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as Io;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:image_downloader/image_downloader.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imgPath;
  final String imgName;

  FullScreenImagePage(this.imgPath, this.imgName);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool permission = false;
  bool downloading = false;
  var progress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPermission();
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
    if (progress == 'Complete') {
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
    //toastFunction(context, 'Double tap to Zoom');

    return new Scaffold(
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backgroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Hero(
                  tag: widget.imgPath,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      widget.imgPath,
                    ),
                    loadingChild: CircularProgressIndicator(),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 1.8,
                    //initialScale: height,
                  ),
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
                    var imageId =
                    await ImageDownloader.downloadImage(widget.imgPath,
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
                        changeIcon(),
                        color: Colors.white,
                      ),
                    )),
              ),
              new Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {},
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
