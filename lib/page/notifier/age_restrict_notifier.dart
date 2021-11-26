import 'dart:typed_data';

import 'package:flutter/material.dart';

class AgeRestrictNotifier extends ChangeNotifier {
  // bool _isAgeRestricted = false;
  bool _isAgeRestricted = true;
  bool get isAgeRestricted => _isAgeRestricted;
  Uint8List _image;
  Uint8List get image => _image;
  set isAgeRestricted(bool duty) {
    _isAgeRestricted = duty;
    notifyListeners();
  }

  set image(Uint8List image) {
    _image = image;
    notifyListeners();
  }

  void reset() {
    _image = null;
    // _isAgeRestricted = false;
  }
}
