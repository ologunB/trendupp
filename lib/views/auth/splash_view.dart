import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/auth/choose_type.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'choose_signup.dart';
import 'login.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (AppCache.getUser() == null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => ChooseSignup(),
          ),
        );
      } else {
        if (AppCache.getUser()!.userType == null) {
          pushReplacement(context, ChooseType());
        } else if (AppCache.getUser()!.userType == 'fan') {
          pushReplacement(context, FanLayout());
          //          pushReplacement(context,WebviewScreen(url: 'https://ravemodal-dev.herokuapp.com/v3/hosted/pay/f173f05fe5805a6d0b96',));
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
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Scaffold(
 //   backgroundColor: AppColors.red,

      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.red, Color(0xff040039)],
              stops: [.3, .7],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: Center(
            child: Hero(
              tag: 'splash',
              child: Image.asset('assets/images/logo3.png', width: 120.h),
            ),
          ),
        ),
      ),
    );
  }
}
