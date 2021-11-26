import 'package:flutter/material.dart';

class DutyChangeNotifier extends ChangeNotifier {
  bool _isDutyOn = true;
  bool get isDutyOn => _isDutyOn;
  String _username = '';
  String get username => _username;
  set isDutyOn(bool duty) {
    _isDutyOn = duty;
    notifyListeners();
  }

  set username(String username) {
    _username = username;
    notifyListeners();
  }
}
