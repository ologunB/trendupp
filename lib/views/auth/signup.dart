import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController code = TextEditingController();

  bool obscureText = true;
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (m) => null,
      builder: (_, AuthViewModel model, __) => Form(
        key: formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: GestureDetector(
          onTap: Utils.offKeyboard,
          child: Scaffold(
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
                  validator: Utils.validateEmail,
                  onChanged: (a) {
                    model.isVerified = false;
                    setState(() {});
                  },
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
                  obscureText: obscureText,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (a) {
                    model.isVerified = false;
                    setState(() {});
                  },
                  validator: Utils.isValidPassword,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/lock.png', height: 20.h),
                    ],
                  ),
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        child: Icon(
                          !obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textGrey,
                          size: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.isVerified)
                  CustomTextField(
                    hintText: 'Paste Verification Code',
                    controller: code,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    isCode: true,
                    maxLength: 6,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseView<AuthViewModel>(
                            onModelReady: (m) => null,
                            builder: (_, AuthViewModel resendModel, __) =>
                                resendModel.busy
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 30.h),
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black),
                                          ),
                                          height: 10.h,
                                          width: 10.h,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          resendModel.resendOtp({
                                            'email': email.text,
                                            'password': password.text,
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 30.h),
                                          child: regularText(
                                            'Resend',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )),
                      ],
                    ),
                  ),
                SizedBox(height: 8.h),
                if (model.isVerified)
                  regularText(
                    'Please check your inbox for a verification code',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                SizedBox(height: 16.h),
                buttonWithBorder(
                    model.isVerified ? 'Verify Mail' : 'Continue with Email',
                    buttonColor: AppColors.red,
                    fontSize: 16.sp,
                    height: 52.h,
                    busy: model.busy,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700, onTap: () {
                  Map<String, dynamic> data = {
                    'email': email.text,
                    'password': password.text,
                    'code': code.text,
                  };
                  if (model.isVerified) {
                    if (code.text.isEmpty) {
                      showSnackBar(context, 'Error', 'Enter OTP');
                      return;
                    }
                    Utils.offKeyboard();
                    model.verify(data);
                  } else {
                    autoValidate = true;
                    setState(() {});
                    if (formKey.currentState!.validate()) {
                      Utils.offKeyboard();
                      model.signup(data);
                    }
                  }
                }),
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
          ),
        ),
      ),
    );
  }
}
