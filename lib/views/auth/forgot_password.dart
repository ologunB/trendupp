import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Form(
                key: formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Scaffold(
                  backgroundColor: AppColors.white,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: AppColors.white,
                    centerTitle: true,
                    leading: SizedBox(),
                    title: Image.asset('assets/images/logo.png', height: 32.h),
                  ),
                  body: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.lightBlack,
                                  size: 16.h,
                                ),
                                SizedBox(width: 6.h),
                                regularText(
                                  'LOGIN',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightBlack,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      regularText(
                        'Forgot Password',
                        fontSize: 24.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        hintText: 'Email Address',
                        controller: email,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Utils.validateEmail,
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
                      SizedBox(height: 42.h),
                      buttonWithBorder('Forgot Password',
                          buttonColor: AppColors.red,
                          fontSize: 16.sp,
                          height: 52.h,
                          busy: model.busy,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w700, onTap: () async {
                        autoValidate = true;
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          Utils.offKeyboard();
                          bool res =
                              await model.forgotPassword({"email": email.text});
                          if (res) {
                            Navigator.pop(context);
                            showSnackBar(context, 'Success',
                                'Check your email to complete Reset');
                          }
                        }
                      }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ))));
  }
}
