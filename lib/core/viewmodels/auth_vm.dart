import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
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
      if (a['isVerified'] == '1') {
        pushAndRemoveUntil(c(), ChooseType());
      }
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
      if (AppCache.getUser() != null) {
        UserData user = AppCache.getUser()!;
        user.verified = true;
        AppCache.setUser(user);
      }
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

  Future signInWithGoogle(BuildContext buildContext) async {
    setBusy(true);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      print(googleSignInAccount);

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        Map<String, dynamic> data = {
          'email': googleSignInAccount.email,
          'password': googleSignInAuthentication.accessToken,
          'isVerified': '1',
          'onboardingStep': '1'
        };

        signup(data);
      } else {
        setBusy(false);
        showSnackBar(buildContext, "Error", 'Choose an account');
      }
    } on PlatformException catch (e) {
      setBusy(false);

      showSnackBar(buildContext, "Error", e.message!);
    } catch (e) {
      setBusy(false);
      showSnackBar(buildContext, "Error", e.toString());
    }
  }

  Future signInWithFB(BuildContext buildContext) async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      Logger().d(accessToken.toJson());
    } else {
      print(result.status);
      print(result.message);
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
