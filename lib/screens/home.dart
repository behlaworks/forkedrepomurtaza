import 'package:aire/screens/chatBot.dart';
import 'package:aire/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:aire/models/pages.dart';
import 'package:aire/data/constants.dart';

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
  int _selectedIndex = 1;

  bool processing = true;

  @override
  void initState() {
    super.initState();
    DatabaseService().getUser().then((value) {
      if(value != 'error'){
      name = value['full_name'];
      age = value['age'];
      referralID = value['referralID'];
      intake = value['examSeries'];
      setState(() {
        processing = false;
      });}
      else{
        setState(() {
          processing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ChatbotPage(),
      Dashboard(name: name, age: age, refID: referralID, intake: intake),
      // ProfilePage(name: name, age: age, refID: referralID, intake: intake)
    ];
    return Scaffold(
      body: Center(
        child: !processing
            ? widgetOptions.elementAt(_selectedIndex)
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
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatbotPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0,0,0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/bot.png', height: 35,),
                              const Text('chat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0,50,0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/house.png', height: 30,),
                              const Text('Home', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
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
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Constants.dark,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        title: const Center(
                            child: Text(
                              "Content locked",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )),
                        content: const SizedBox(
                            height: 50,
                            child: Center(
                                child: Column(
                                  children: [
                                    Text("Buy membership to unlock!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ))),
                        actions: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromWidth(200)),
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      );
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
                          shape: BoxShape.circle,
                          color: Colors.red
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Image.asset('assets/scan.png'),
                        ),
                      ),
                    ),
                    const Text('Scan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}