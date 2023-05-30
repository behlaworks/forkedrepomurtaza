import 'package:a_level_pro/screens/addSubjectPage.dart';
import 'package:a_level_pro/screens/dashboard.dart';
import 'package:a_level_pro/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:a_level_pro/models/pages.dart';
import 'package:a_level_pro/data/constants.dart';

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
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    AddSubjectPage(),
    Dashboard(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height*0.11,
        child: BottomNavigationBar(
          backgroundColor: Constants.dark,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Subject'),
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
