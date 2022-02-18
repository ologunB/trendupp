import 'package:flutter/material.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'choose_type.dart';
import 'choose_signup.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (AppCache.getIsFirst()) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => ChooseSignup()));
       // pushReplacement(context, ChooseSignup());
      } else {
        String? uid; //= AppCache.instance.currentUser?.uid;
        if (uid == null) {
          pushReplacement(context, ChooseType());
        } else {
          pushReplacement(context, ChooseType());
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
