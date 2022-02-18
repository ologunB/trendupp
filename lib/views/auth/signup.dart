import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/choose_type.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        children: [
          SizedBox(height: 50.h),
          regularText(
            'Create an account',
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
          CustomTextField(
            hintText: 'Paste Verification Code',
            controller: otp,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            isCode: true,
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.h),
                    child: regularText(
                      'Resend',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          regularText(
            'Please check your inbox for a verification code',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
          ),
          SizedBox(height: 16.h),
          buttonWithBorder(
            'Continue with Email',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
            onTap: () => push(context, ChooseType()),
          ),
          SizedBox(height: 16.h),
          regularText(
            'By signing up, you agree to our terms and privacy\npolicy. We do not allow inappropriate content. You\nmust 18 years old to have an account',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            color: AppColors.textGrey,
          ),
        ],
      ),
    );
  }
}
