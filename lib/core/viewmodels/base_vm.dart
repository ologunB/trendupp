import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/core/utils/navigator.dart';

import '../../locator.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  NavigationService navigate = locator<NavigationService>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  log(dynamic data) {
    Logger l = Logger();
    l.d(data);
  }
}
