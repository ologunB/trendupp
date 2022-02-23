import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Utils {
  static String raveEncryptionKey = 'FLWSECK_TEST079f656d190b';
  static String ravePublicKey =
      'FLWPUBK_TEST-4775239fc89f256ef2f24cddcebc17e1-X';

  static void offKeyboard() async {
    await SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
  }

  static String? isValidPassword(String? value) {
    value = value!.trim();
    if (value.trim().isEmpty) {
      return "Password is required";
    } else if (value.trim().length < 6) {
      return "Password is too short";
    } else if (!value.trim().contains(RegExp(r'[0-9]'))) {
      return "Password must contain a number";
    } else if (!value.trim().toUpperCase().contains(RegExp(r'[A-Z]'))) {
      return "Password must contain a letter";
    } else if (!value.trim().contains(RegExp(r'[A-Z]'))) {
      return "Password must contain an upper case letter";
    } else if (!value.trim().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain a special character";
    }
    return null;
  }

  static String? isValidName(String? value, String type, int length) {
    if (value!.isEmpty) {
      return '$type cannot be Empty';
    } else if (value.length < length) {
      return '$type is too short';
    } else if (value.length > 1999) {
      return '$type max length is 2000';
    }
    return null;
  }

  static String randomString({int no = 12}) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < no; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  static String stringToDate(String a) {
    DateTime now = DateTime.now();
    DateTime then = DateTime.parse(a);

    if (now.year == then.year &&
        now.month == then.month &&
        now.day == then.day) {
      return 'Today';
    } else if (now.year == then.year &&
        now.month == then.month &&
        now.day - 1 == then.day) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(a)) +
          ' at ' +
          DateFormat(' hh:mm a').format(DateTime.parse(a));
    }
  }

  static String? validateEmail(String? value) {
    value = value!.trim();
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  static void unfocusKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      return;
    }
    currentFocus.unfocus();
  }

  static SliverGridDelegate gridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16.h,
      mainAxisSpacing: 16.h,
      childAspectRatio:
          ScreenUtil.defaultSize.width / ScreenUtil.defaultSize.width * .85,
    );
  }
}

extension customStringExtension on String {
  toTitleCase() {
    final words = this.toString().toLowerCase().split(' ');
    var newWord = '';
    for (var word in words) {
      if (word.isNotEmpty)
        newWord += '${word[0].toUpperCase()}${word.substring(1)} ';
    }

    return newWord;
  }

  toAmount() {
    return NumberFormat("#,##0", "en_US").format(double.tryParse(this) ?? 0.00);
  }

  getSingleInitial() {
    return this.split('')[0].toUpperCase();
  }

  sanitizeToDouble() {
    return double.tryParse(this.replaceAll(",", ""));
  }
}
