import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  ProfileDetails({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  String? metadata = FirebaseAuth.instance.currentUser!.metadata.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Profile Details"),
        backgroundColor: const Color(0xff296e48).withOpacity(0.7),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Username: $user",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              "Email: $email",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              "Metadata: $metadata",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        )
      );
    }
  }
//   @override
//   Widget build(BuildContext context) {
//     // ignore: avoid_unnecessary_containers
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile Details"),
//         backgroundColor: const Color(0xff296e48).withOpacity(0.7),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 hintText: "Enter your name",
//               ),
//             ),
//           ]
//         ),
//       ),
//     );
//   }
// }

// Widget to display text in the profile page