import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import '../base_view.dart';
import 'login.dart';
import 'signup.dart';
import 'dart:io';

class ChooseSignup extends StatefulWidget {
  const ChooseSignup({Key? key}) : super(key: key);

  @override
  _ChooseSignupState createState() => _ChooseSignupState();
}

class _ChooseSignupState extends State<ChooseSignup>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetFloat;

  @override
  void initState() {
    super.initState();

    AppCache.haveFirstView();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _offsetFloat = Tween(begin: Offset(0.0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _offsetFloat!.addListener(() {
      setState(() {});
    });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => Scaffold(
              //      backgroundColor: Color(0xff040039),
              body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(24.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.red, Color(0xff040039)],
                    stops: [.3, .7],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Hero(
                      tag: 'splash',
                      child:
                          Image.asset('assets/images/logo3.png', height: 130.h),
                    ),
                    SizedBox(height: 150.h),
                    SlideTransition(
                      position: _offsetFloat!,
                      child: model.busy
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(height: 18.h),
                                regularText(
                                  'Signing In...',
                                  fontSize: 13.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                InkWell(
                                  onTap: () => push(context, Signup()),
                                  child: item('Sign  up with  Email', 'mail'),
                                ),
                                SizedBox(height: 18.h),
                                InkWell(
                                  onTap: () => model.signInWithGoogle(context),
                                  child: item('Continue with Google', 'gg'),
                                ),
                                SizedBox(height: 18.h),
                                InkWell(
                                  onTap: () => model.signInWithFB(context),
                                  child: item('Continue with Facebook', 'fb'),
                                ),
                                if (Platform.isIOS)
                                  Padding(
                                    padding: EdgeInsets.only(top: 18.h),
                                    child: InkWell(
                                      onTap: () => model.signinApple(context),
                                      child: item('Continue with Apple', 'ap'),
                                    ),
                                  ),
                                SizedBox(height: 51.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => push(context, Login()),
                                      child: regularText(
                                        'Login',
                                        fontSize: 16.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget item(String a, String b) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.h),
        color: AppColors.grey2,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/$b.png',
              width: 24.h,
            ),
          ),
          SizedBox(height: 10.h),
          regularText(
            a,
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
