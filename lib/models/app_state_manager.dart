import 'dart:async';

import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {

  final List _enrolledSubs = ['Physics'];

  List get enrolledSubs => _enrolledSubs;

  addEnrolledSub(String sub) {
    _enrolledSubs.add(sub);
    notifyListeners();
  }
  bool _initialized = false;
  bool _registered = false;
  bool _loggedIn = false;
  bool _isLanded = false;
  bool _goToRegister = false;
  bool _goToLogin = false;
  bool get isInitialized => _initialized;

  bool get registered => _registered;

  bool get goToRegisters => _goToRegister;

  bool get goToLogin => _goToLogin;

  bool get isLoggedIn => _loggedIn;

  bool get isLanded => _isLanded;

  void initializeApp() async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? action = prefs.getString('hash');
    Timer(
      const Duration(milliseconds: 3000),
          () {
          _initialized = true;
          notifyListeners();
      },
    );
  }

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

}
