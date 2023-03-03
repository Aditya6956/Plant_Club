// import 'package:flutter/material.dart';
// import '../constants.dart';

// class ScanPage extends StatefulWidget {
//   const ScanPage({Key? key}) : super(key: key);

//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> {
//   @override
//   Widget build(BuildContext context) {
//     // Turn on the camera and capture the image
//     // Then send the image to the server to get the result
//     // Then show the result in the screen

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.close,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.share,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/code-scan.png',
//                 height: 100,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Scan the Image here',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// Size size = MediaQuery.of(context).size;

// ignore: prefer_const_constructors
// return Scaffold(
// body: Stack(
//   children: [
//     Positioned(
//         top: 50,
//         left: 20,
//         right: 20,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Constants.primaryColor.withOpacity(.15),
//                 ),
//                 child: Icon(
//                   Icons.close,
//                   color: Constants.primaryColor,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 debugPrint('favorite');
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Constants.primaryColor.withOpacity(.15),
//                 ),
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.share,
//                     color: Constants.primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )),
//     Positioned(
//       top: 100,
//       right: 20,
//       left: 20,
//       child: Container(
//         width: size.width * .8,
//         height: size.height * .8,
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/code-scan.png',
//                 height: 100,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Tap to Scan',
//                 style: TextStyle(
//                   color: Constants.primaryColor.withOpacity(.80),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
// }

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ScanPage extends StatefulWidget {
  final CameraDescription camera;
  const ScanPage({super.key, required this.camera});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;

      // final path =
      //     join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      // await _cameraController.takePicture();

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      // Attempt to take a picture and log where it's been saved.
      final image = await _cameraController.takePicture();
      // print(image.path);

      FileImage(File(image.path));

      // ignore: use_build_context_synchronously
      Navigator.pop(context, image.path);
    } catch (e) {
      print(e);
    }
  }

  // Scan the above imgage for plant identification and return the result

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      SafeArea(
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: const Icon(Icons.camera),
              onPressed: () {
                _takePicture(context);
              },
            ),
          ),
        ),
      )
    ]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
