import 'package:hive_flutter/hive_flutter.dart';
import 'package:mms_app/core/models/user_model.dart';

const String kUserBox = 'userBox';
const String isFirstKey = 'noBiometricKoeypipo';
const String tokenKey = 'tokenKeyrgewr';
const String userKey = 'userKeytrte';
const String isFirst = 'isFirsterterrtt';

class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);

  static void haveFirstView() {
    _userBox.put(isFirst, false);
  }

  static bool getIsFirst() {
    final bool data = _userBox.get(isFirst, defaultValue: true);
    return data;
  }

  static void setToken(String a) {
    _userBox.put(tokenKey, a);
  }

  static String? getToken() {
    return _userBox.get(tokenKey);
  }

  static void setUser(UserData a) {
    _userBox.put(userKey, a.toJson());
  }

  static UserData? getUser() {
    dynamic data = _userBox.get(userKey);
    if (data == null) {
      return null;
    } else {
      return UserData.fromJson(data);
    }
  }

  static Future<void> clear() async {
    await _userBox.clear();
  }

  static void clean(String key) {
    _userBox.delete(key);
  }
}
