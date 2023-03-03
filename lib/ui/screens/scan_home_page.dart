// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_club/ui/scan_page.dart';

class ScanHomePage extends StatefulWidget {
  const ScanHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanHomePageState createState() => _ScanHomePageState();
}

class _ScanHomePageState extends State<ScanHomePage> {
  final ImagePicker _picker = ImagePicker();

  // ignore: avoid_init_to_null
  String? _path = null;

  void _showPhotoLibrary() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file!.path;
    });
  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ScanPage(camera: camera)));

    setState(() {
      _path = result;
    });
  }

  Future<List> scanImage(File image) async {
    final visionImage = FirebaseVisionImage.fromFile(image);
    final plantDetector = FirebaseVision.instance.imageLabeler();
    final plant = await plantDetector.processImage(visionImage);
    for (ImageLabel label in plant) {
      final double? confidence = label.confidence;
      setState(() {
        
        var text = "$label.text   $confidence.toStringAsFixed(2) \n";

        print(text);
      });
    }
    return plant;
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCamera();
                    },
                    leading: const Icon(Icons.photo_camera),
                    title: const Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from photo library"))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            // ignore: unnecessary_null_comparison
            _path == null
                ? Center(
                    child: Container(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset(
                      "assets/images/code-scan.png",
                      fit: BoxFit.fitHeight,
                      height: 200,
                      width: 200,
                    ),
                  ))
                : FutureBuilder(
                    future: scanImage(File(_path!)),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      print(_path);
                      // print("Snapshot data is:$snapshot");
                      if (snapshot.hasData) {
                        return Center(
                            child: Container(
                          padding: const EdgeInsets.all(50),
                          child: Text(snapshot.data![0].text),
                        ));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      setState(() {});
                    }),
            // : Center(
            //   child: Container(
            //     padding: const EdgeInsets.all(50),
            //     child: Image.file(File(_path!), fit: BoxFit.fitHeight, height: 400, width: 400,),
            //   )
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: const Text("Take Picture",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                _showOptions(context);
              },
            )
          ]),
        ));
  }
}
