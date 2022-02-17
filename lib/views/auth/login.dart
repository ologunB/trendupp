import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/choose_type.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(24.h),
            shrinkWrap: true,
            children: [
              Image.asset('assets/images/logo.png', height: 60.h),
              SizedBox(height: 150.h),
              item('Sign  up with  Email', 'mail'),
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
                      push(context, ChooseType());
                    },
                    child: regularText(
                      'Login',
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String a, String b) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.h), color: AppColors.grey2),
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
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
