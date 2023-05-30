import 'package:a_level_pro/components/blackButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/constants.dart';
import '../models/app_state_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            drawerScrimColor: Constants.dark,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Constants.dark,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Murtaza Mustafa",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "Age: 19",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "INTAKE: June '23",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        "Personal statistics",
                        style: TextStyle(
                            fontSize: 22,
                            color: Constants.dark,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.1),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 46,
                                      color: Constants.dark,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.1),
                                ),
                                Text(
                                  'Subject in progress',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Constants.dark,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '4',
                                  style: TextStyle(
                                      fontSize: 46,
                                      color: Constants.dark,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.1),
                                ),
                                Text(
                                  'Days streak',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Constants.dark,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: BlackButton(
                      text: "Sign Out",
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        myProvider.logout();
                      }),
                )
              ]),
            )));
  }
}
