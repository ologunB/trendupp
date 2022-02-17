import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController current = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController newPass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
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
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            title: 'New Password',
            hintText: '',
            controller: newPass,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            title: 'Confirm New Password',
            hintText: '',
            controller: newPass2,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 42.h),
          buttonWithBorder(
            'Update Password',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
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
