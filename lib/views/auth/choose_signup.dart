import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'login.dart';
import 'signup.dart';

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
    return Scaffold(
      backgroundColor: Color(0xff040039),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(24.h),
        child: ListView(
          shrinkWrap: true,
          children: [
            Hero(
                tag: 'splash',
                child: Image.asset('assets/images/logo2.png', height: 100.h)),
            SizedBox(height: 150.h),
            SlideTransition(
              position: _offsetFloat!,
              child: Column(
                children: [
                  InkWell(
                    onTap: () => push(context, Signup()),
                    child: item('Sign  up with  Email', 'mail'),
                  ),
                  SizedBox(height: 18.h),
                  item('Continue with Google', 'gg'),
                  SizedBox(height: 18.h),
                  item('Continue with Facebook', 'fb'),
                  SizedBox(height: 51.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          push(context, Login());
                        },
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
    );
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
