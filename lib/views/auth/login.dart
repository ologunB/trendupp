import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,        leading: SizedBox(),

        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        children: [
          SizedBox(height: 70.h),
          regularText(
            'Login',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            hintText: 'Email Address',
            controller: email,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/mail.png',
                  height: 20.h,
                  color: Color(0xffAEB5BC),
                ),
              ],
            ),
          ),
          CustomTextField(
            hintText: 'Password',
            controller: password,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/lock.png', height: 20.h),
              ],
            ),
          ),
          SizedBox(height: 36.h),
          buttonWithBorder('Login',
              buttonColor: AppColors.red,
              fontSize: 16.sp,
              height: 52.h,
              textColor: AppColors.white,
              fontWeight: FontWeight.w700,
              onTap: () => push(context, FanLayout())),
        ],
      ),
    );
  }
}
