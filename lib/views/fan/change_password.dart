import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController current = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController newPass2 = TextEditingController();

  bool obscureText = true;
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
                                  'SETTINGS',
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
                        'Change Password',
                        fontSize: 24.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        title: 'Current Password',
                        hintText: '',
                        controller: current,
                        textInputType: TextInputType.text,
                        validator: Utils.isValidPassword,
                        textInputAction: TextInputAction.next,
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
                      CustomTextField(
                        title: 'New Password',
                        hintText: '',
                        controller: newPass,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: Utils.isValidPassword,
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
                      CustomTextField(
                        title: 'Confirm New Password',
                        hintText: '',
                        controller: newPass2,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (a) {
                          if (newPass2.text.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (newPass.text != newPass2.text) {
                            return 'Password must be the same';
                          }
                          return null;
                        },
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
                      SizedBox(height: 42.h),
                      buttonWithBorder('Update Password',
                          buttonColor: AppColors.red,
                          fontSize: 16.sp,
                          height: 52.h,
                          busy: model.busy,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w700, onTap: () async {
                        Map<String, dynamic> data = {
                          "oldPassword": current.text,
                          "newPassword": newPass.text
                        };
                        autoValidate = true;
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          Utils.offKeyboard();
                          bool res = await model.changePassword(data);
                          if (res) {
                            autoValidate = false;
                            setState(() {});
                            current.text = '';
                            newPass.text = '';
                            newPass2.text = '';
                          }
                        }
                      }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ))));
  }

  File? imageFile;

  Future getImageGallery() async {
    Utils.offKeyboard();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      imageFile = File(result.files.first.path!);
      setState(() {});
    } else {
      return;
    }
  }
}
