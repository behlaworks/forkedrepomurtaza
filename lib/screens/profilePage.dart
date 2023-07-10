import 'package:a_level_pro/components/common%20ui%20elements/blackButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../data/constants.dart';
import '../models/app_state_manager.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String age;
  final String refID;
  final String intake;

  const ProfilePage(
      {Key? key,
      required this.name,
      required this.age,
      required this.refID,
      required this.intake})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snackBar = const SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      backgroundColor: Color(0xffB4E33D),
      content: Text(
        'Referral code copied!',
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          drawerScrimColor: Constants.dark,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Constants.dark,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 100,
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (name[0].toUpperCase() + name.substring(1))
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'age: $age',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Your referral code: ",
                    style: TextStyle(
                        fontSize: 22,
                        color: Constants.dark,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.1),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 60,
              decoration: BoxDecoration(
                  color: Constants.dark,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      refID,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: Constants.referralId.toString()))
                              .then((value) {
                            //only if ->
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }); // -> show a notification
                        },
                        icon: const Icon(
                          Icons.content_copy,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.37,
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
          ]))),
    );
  }
}
