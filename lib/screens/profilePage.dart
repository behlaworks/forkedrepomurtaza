import 'package:aire/components/common%20ui%20elements/blackButton.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/nextrev.png',
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Image.asset(
                  'assets/profile.png',
                  height: 70,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Hi! ${name[0].toUpperCase() + name.substring(1)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.73,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 8, 8, 10),
                    child: Row(
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  ProfileBox(
                      title: "Name",
                      data: name[0].toUpperCase() + name.substring(1),
                      image: "assets/userProfile.png"),
                  ProfileBox(
                      title: "Email",
                      data: FirebaseAuth.instance.currentUser!.email.toString(),
                      image: "assets/mail.png"),
                  const ProfileBox(
                      title: "Mobile No",
                      data: "Not provided",
                      image: "assets/phone.png"),
                  ProfileBox(
                      title: "Age",
                      data: age,
                      image: "assets/age.png"),
                  const ProfileBox(
                      title: "Gender",
                      data: "Not provided",
                      image: "assets/gender.png"),
                  ProfileBox(
                      title: "Intake",
                      data: intake,
                      image: "assets/calendar.png"),
                  const ProfileBox(
                      title: "City",
                      data: "Not provided",
                      image: "assets/building.png"),
                  const ProfileBox(
                      title: "Country",
                      data: "Not provided",
                      image: "assets/globe.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // var snackBar = const SnackBar(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    //   backgroundColor: Color(0xffB4E33D),
    //   content: Text(
    //     'Referral code copied!',
    //     style: TextStyle(
    //         color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
    //   ),
    // );
    // final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    // return Scaffold(
    //     drawerScrimColor: Constants.dark,
    //     backgroundColor: Colors.white,
    //     body: SingleChildScrollView(
    //         child: Column(children: [
    //       Container(
    //           height: MediaQuery.of(context).size.height * 0.3,
    //           width: MediaQuery.of(context).size.width,
    //           decoration: BoxDecoration(
    //               color: Constants.dark,
    //               borderRadius: const BorderRadius.only(
    //                   bottomLeft: Radius.circular(20),
    //                   bottomRight: Radius.circular(20))),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     GestureDetector(
    //                       onTap: () => {Navigator.pop(context)},
    //                       child: Container(
    //                         height: 42,
    //                         width: 42,
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(8), color: Constants.grey),
    //                         child: const Center(
    //                           child: Icon(
    //                             Icons.arrow_back_ios,
    //                             color: Colors.black,
    //                             size: 15,
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.7,
    //                 height: MediaQuery.of(context).size.height * 0.2,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Image.asset(
    //                       'assets/face.png',
    //                       height: 100,
    //                     ),
    //                     const SizedBox(
    //                       width: 70,
    //                     ),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Text(
    //                           (name[0].toUpperCase() + name.substring(1))
    //                               .toString(),
    //                           style: const TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 20,
    //                               fontWeight: FontWeight.w800),
    //                         ),
    //                         const SizedBox(
    //                           height: 5,
    //                         ),
    //                         Text(
    //                           'age: $age',
    //                           style: const TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 20,
    //                               fontWeight: FontWeight.w800),
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           )),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
    //             child: Text(
    //               "Your referral code: ",
    //               style: TextStyle(
    //                   fontSize: 22,
    //                   color: Constants.dark,
    //                   fontWeight: FontWeight.w700,
    //                   letterSpacing: -0.1),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         width: MediaQuery.of(context).size.width * 0.95,
    //         height: 60,
    //         decoration: BoxDecoration(
    //             color: Constants.dark,
    //             borderRadius: BorderRadius.circular(12)),
    //         child: Padding(
    //           padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 refID,
    //                 style: const TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w800),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     Clipboard.setData(ClipboardData(
    //                             text: Constants.referralId.toString()))
    //                         .then((value) {
    //                       //only if ->
    //                       ScaffoldMessenger.of(context)
    //                           .showSnackBar(snackBar);
    //                     }); // -> show a notification
    //                   },
    //                   icon: const Icon(
    //                     Icons.content_copy,
    //                     color: Colors.white,
    //                   ))
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: MediaQuery.of(context).size.height * 0.37,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
    //         child: BlackButton(
    //             text: "Sign Out",
    //             onPressed: () {
    //               FirebaseAuth.instance.signOut();
    //               myProvider.logout();
    //             }),
    //       )
    //     ])));
  }
}

class ProfileBox extends StatelessWidget {
  final String title;
  final String data;
  final String image;

  const ProfileBox(
      {Key? key, required this.title, required this.data, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              image,
              height: 30,
            ),
            const SizedBox(
              width: 17,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(data,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width *
                        0.8, // The height of the line
                    color: Colors.black, // The color of the line
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
