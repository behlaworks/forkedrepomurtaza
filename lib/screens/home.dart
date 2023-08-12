import 'package:aire/components/common%20ui%20elements/dialog.dart';
import 'package:aire/screens/chatBot.dart';
import 'package:aire/screens/dashboard.dart';
import 'package:aire/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:aire/models/pages.dart';
import 'package:aire/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cloud_firestore.dart';

class Home extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: Pages.home, key: ValueKey(Pages.home), child: const Home());
  }

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  String age = '';
  String referralID = '';
  String intake = '';

  bool processing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('full_name') == null ||
        prefs.getString('age') == null ||
        prefs.getString('referralID') == null ||
        prefs.getString('intake') == null) {
      await DatabaseService().getUser().then((value) async {
        if (value != 'error') {
          name = value['full_name'];
          age = value['age'];
          referralID = value['referralID'];
          intake = value['examSeries'];
          await prefs.setString('full_name', name);
          await prefs.setString('age', age);
          await prefs.setString('referralID', referralID);
          await prefs.setString('intake', intake);
          setState(() {
            processing = false;
          });
        } else {
          setState(() {
            processing = false;
          });
        }
      });
    } else {
      name = prefs.getString("full_name")!;
      age = prefs.getString("age")!;
      referralID = prefs.getString("referralID")!;
      intake = prefs.getString("examSeries")!;
      setState(() {
        processing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const ChatbotPage(),
      Dashboard(name: name, age: age, refID: referralID, intake: intake)
    ];
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f7),
      body: Center(
        child: !processing
            ? widgetOptions.elementAt(1)
            : CircularProgressIndicator(
                color: Constants.dark,
                strokeWidth: 4,
              ),
      ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          color: const Color(0xfff2f3f7),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatbotPage()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/bot.png',
                                  height: 35,
                                ),
                                const Text(
                                  'chat',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Menu(name: name, age: age, intake: intake, refID: referralID,)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/menu.png',
                                  height: 25,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Text(
                                  'Menu',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomAlertDialog(
                            title: "Premium feature!",
                            text: "Buy subscription to unlock");
                      });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Image.asset('assets/scan.png'),
                          ),
                        ),
                      ),
                      const Text(
                        'Scan',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
