import 'package:a_level_pro/screens/addSubjectPage.dart';
import 'package:a_level_pro/screens/chatBot.dart';
import 'package:a_level_pro/screens/dashboard.dart';
import 'package:a_level_pro/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:a_level_pro/models/pages.dart';
import 'package:a_level_pro/data/constants.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      Dashboard(name: name,),
      ProfilePage(name: name, age: age, refID: referralID, intake: intake)
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
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.11,
        child: BottomNavigationBar(
          backgroundColor: Constants.dark,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'Add Subject'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme:
              const IconThemeData(color: Colors.white, opacity: 1, size: 25),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, opacity: 0.3, size: 25),
        ),
      ),
    );
  }
}
