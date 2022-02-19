import 'package:flutter/material.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'choose_type.dart';
import 'choose_signup.dart';
import 'login.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    //  AppCache.clear();
    Future.delayed(Duration(seconds: 2), () {
      if (AppCache.getUser() == null) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => ChooseSignup()));
      } else {
        if (AppCache.getUser()!.userType == 'fan') {
          pushReplacement(context, FanLayout());
        } else if (AppCache.getUser()!.userType == 'creator') {
          pushReplacement(context, CreatorLayout());
        } else if (!AppCache.getUser()!.verified!) {
          pushReplacement(context, Login(isVerify: true));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.offKeyboard();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(w, h),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => Scaffold(
              backgroundColor: Color(0xff040039),
              body: Center(
                  child: Hero(
                      tag: 'splash',
                      child: Image.asset('assets/images/logo2.png',
                          width: 120.h))),
            ));
  }
}
