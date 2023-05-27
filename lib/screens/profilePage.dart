import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
        child: Scaffold(
        drawerScrimColor: Constants.dark,
        backgroundColor: Colors.white,
        body: Column(
            children: [
            Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Constants.dark,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Murtaza Mustafa",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "19 years",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "A-levels",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
        )]
        )
        )
    );
  }
}
