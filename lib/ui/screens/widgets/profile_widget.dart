import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget route;
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 7),
      height: 80,
      width: 450,
      child: Card(
        elevation: 6,
        color: Colors.green.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => route)),
          },
          splashColor: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
