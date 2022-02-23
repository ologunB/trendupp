import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      await getAccount();
      user = AppCache.getUser()!;
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

  Future<void> getAccount() async {
    setBusy(true);
    try {
      UserData user = await _authApi.getAccount();
      user.token = AppCache.getToken();
      AppCache.setUser(user);
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
      String token = await _authApi.verify(a);
      setBusy(false);
      AppCache.setToken(token);
      UserData user = UserData(token: token, verified: true, email: a['email']);
      AppCache.setUser(user);
      pushReplacement(c(), ChooseType());
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> resendOtp(Map<String, String> a) async {
    setBusy(true);
    try {
      await _authApi.resendOtp(a);
      setBusy(false);
      showSnackBar(c(), 'Success', 'OTP has been resent to email');
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

  String? resolvedName;

  Future<bool> resolveAccount(String n, String c) async {
    setBusy(true);
    try {
      resolvedName = await _authApi.resolveAccount(n, c);
      error = null;
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      return false;
    }
  }

  Future<String?> socialCheck(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      String res = await _authApi.socialCheck(a);
      setBusy(false);
      return res;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return null;
    }
  }

  Future<void> socialSignup(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      UserData user = await _authApi.socialSignup(a);
      AppCache.setToken(user.token!);
      AppCache.setUser(user);
      await getAccount();
      pushAndRemoveUntil(c(), ChooseType());
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> socialLogin(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      UserData user = await _authApi.socialLogin(a);
      AppCache.setToken(user.token!);
      AppCache.setUser(user);
      await getAccount();
      user = AppCache.getUser()!;
      if (user.userType == null) {
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

  Future signInWithGoogle(BuildContext buildContext) async {
    setBusy(true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        List<String> list = googleSignInAccount.displayName!.split(' ');
        Map<String, dynamic> data = {
          "firstName": list.first,
          "lastName": list.length > 1 ? list[1] : '',
          "email": googleSignInAccount.email,
          "picture": googleSignInAccount.photoUrl,
          "onboardingStep": 1
        };
        String? checkRes = await socialCheck(data);
        if (checkRes == 'This user does not exists') {
          socialSignup(data);
        } else if (checkRes == 'This user already exists') {
          socialLogin(data);
        }
      } else {
        setBusy(false);
        showSnackBar(buildContext, "Error", 'Choose an account');
      }
    } on PlatformException catch (e) {
      setBusy(false);
      print(e.message);
      showSnackBar(buildContext, "Error", e.message!);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      return false;
    } catch (e) {
      setBusy(false);
      showSnackBar(buildContext, "Error", e.toString());
    }
  }

  Future signInWithFB(BuildContext buildContext) async {
    setBusy(true);
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        Map<String, dynamic> fbRes = await FacebookAuth.instance.getUserData();
        log(fbRes);
        List<String> list = fbRes['name'].split(' ');
        Map<String, dynamic> data = {
          "firstName": list.first,
          "lastName": list.length > 1 ? list[1] : '',
          "email": fbRes['email'],
          "picture": fbRes['picture']['data']['url'],
          "onboardingStep": 1
        };
        String? checkRes = await socialCheck(data);
        if (checkRes == 'This user does not exists') {
          socialSignup(data);
        } else if (checkRes == 'This user already exists') {
          socialLogin(data);
        }
        setBusy(false);
      } else {
        setBusy(false);
        showSnackBar(buildContext, "Error", result.message!);
      }
    } on PlatformException catch (e) {
      setBusy(false);
      showSnackBar(buildContext, "Error", e.message!);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      return false;
    } catch (e) {
      setBusy(false);
      showSnackBar(buildContext, "Error", e.toString());
    }
  }

  Future<void> checkLink(String a) async {
    setBusy(true);
    try {
      bool verified = await _authApi.checkLink(a);
      error = null;
      isVerified = verified;
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }

  Future<bool> changePassword(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _authApi.changePassword(a);
      showSnackBar(c(), 'Success', 'Password has been changed successfully');
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  Future<bool> forgotPassword(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _authApi.forgotPassword(a);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
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
