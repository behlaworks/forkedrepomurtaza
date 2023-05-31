import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  final List _enrolledSubs = ['Physics'];

  List get enrolledSubs => _enrolledSubs;

  addEnrolledSub(String sub) {
    _enrolledSubs.add(sub);
    notifyListeners();
  }
  final List _urlList = [];

  List get urlList => _urlList;

  addUrlList(List url) {
    _urlList.add(url);
    notifyListeners();
  }
  bool _initialized = false;
  bool _loggedIn = FirebaseAuth.instance.currentUser == null ? false : true;

  bool get isInitialized => _initialized;

  bool get isLoggedIn => _loggedIn;

  void initializeApp() async {
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

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
