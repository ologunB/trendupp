import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/auth_api.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/auth/choose_type.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';
import 'dart:io';

class AuthViewModel extends BaseModel {
  final AuthApi _authApi = locator<AuthApi>();
  String? error;
  bool isVerified = false;

  Future<void> signup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _authApi.signup(a);
      isVerified = true;
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  void toVerify(bool b) {
    isVerified = b;
    setBusy(false);
  }

  Future<void> login(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      UserData user = await _authApi.login(a);
      AppCache.setToken(user.token!);
      AppCache.setUser(user);
      if (!user.verified!) {
        isVerified = true;
      } else if (user.userType == null) {
        pushAndRemoveUntil(c(), ChooseType());
      } else if (user.userType == 'fan') {
        pushAndRemoveUntil(c(), FanLayout());
      } else if (user.userType == 'creator') {
        pushAndRemoveUntil(c(), CreatorLayout());
      }
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> verify(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _authApi.verify(a);
      setBusy(false);
      UserData user = AppCache.getUser()!;
      user.verified = true;
      AppCache.setUser(user);
      pushReplacement(c(), ChooseType());
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> resendOtp(String a) async {
    setBusy(true);
    try {
      await _authApi.resendOtp({'email': a});
      setBusy(false);
      showSnackBar(c(), 'Success', 'OTP has been sent to mail');
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<String?> uploadImage(File file) async {
    setBusy(true);
    try {
      String a = await _authApi.uploadImage(file);
      setBusy(false);
      showSnackBar(c(), 'Success', 'OTP has been sent to mail');
      return a;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return null;
    }
  }

  Future<bool> updateProfile(Map<String, String> a, Widget? goto) async {
    setBusy(true);
    try {
      await _authApi.updateProfile(a);
      setBusy(false);
      Map<String, dynamic> user = AppCache.getUser()!.toJson();
      a.forEach((key, value) {
        user[key] = value;
      });
      AppCache.setUser(UserData.fromJson(user));
      if (goto != null) {
        pushAndRemoveUntil(c(), goto);
      }
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  Future<void> checkLink(String a) async {
    setBusy(true);
    try {
      bool res = await _authApi.checkLink({"link": a});
      isVerified = res;
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  String? resolvedName;

  Future<bool> resolveAccount(String n, String c) async {
    setBusy(true);
    try {
      resolvedName = await _authApi.resolveAccount(n, c);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      return false;
    }
  }

  BuildContext c() => navigate.navigationKey.currentContext!;

  void showDialog(CustomException e) {
    showSnackBar(
      navigate.navigationKey.currentContext!,
      'Error',
      e.message,
      color: AppColors.red,
    );
  }
}
