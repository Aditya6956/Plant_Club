import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_club/ui/screens/profile_details.dart';
import 'package:plant_club/ui/screens/signin_screen.dart';
import '/constants.dart';
import '/ui/screens/widgets/profile_widget.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? user = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withOpacity(.5),
                  width: 5.0,
                ),
              ),
              child: const Icon(
                Icons.person_outline_sharp,
                color: Colors.black,
                size: 75.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * .3,
              child: Row(
                children: [
                  Text(
                    "\t\t\t\t$user",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              email!,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ignore: prefer_const_constructors
                  ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                    route: ProfileDetails(),
                  ),
                  // // ignore: prefer_const_constructors
                  // ProfileWidget(
                  //   icon: Icons.settings,
                  //   title: 'Settings',
                  // ),
                  // // ignore: prefer_const_constructors
                  // ProfileWidget(
                  //   icon: Icons.share,
                  //   title: 'Share',
                  // ),
                  // ignore: prefer_const_constructors
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged Out'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: const Text('Log Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
