import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_club/ui/screens/signin_screen.dart';
import './widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(
      String name, String password, String email) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // ignore: deprecated_member_use
      user?.updateProfile(displayName: name); //added this line
      return (user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/signup.png"),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  registerWithEmailAndPassword(_userNameTextController.text,
                      _passwordTextController.text, _emailTextController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                  );
                }),
                signInOption(),
              ],
            ),
          ))),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have an account?",
            style: TextStyle(color: Color.fromARGB(179, 19, 1, 1))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: const Text(
            " Sign In",
            style: TextStyle(
                color: Color.fromARGB(255, 20, 2, 2),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
