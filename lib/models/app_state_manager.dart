import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {

  final List _enrolledSubs = ['Physics'];

  List get enrolledSubs => _enrolledSubs;

  addEnrolledSub(String sub) {
    _enrolledSubs.add(sub);
    notifyListeners();
  }
}
