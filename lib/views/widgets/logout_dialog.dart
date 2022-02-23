import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/auth/choose_signup.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/core/routes/router.dart';
import 'buttons.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext cContext) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Container(
        color: AppColors.textGrey.withOpacity(.1),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: ScreenUtil.defaultSize.width - 8.h,
                  padding: EdgeInsets.all(10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(cContext);
                        },
                        child: Image.asset(
                          'assets/images/close.png',
                          width: 28.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                regularText('Are you sure you want to\nlogout?',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    textAlign: TextAlign.center),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.h),
                  child: buttonWithBorder(
                    'Confirm',
                    buttonColor: AppColors.red,
                    fontSize: 14.sp,
                    height: 40.h,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                    onTap: () {
                      Navigator.pop(cContext);
                      AppCache.clear();
                      fIndexNotifier.value = 0;
                      cIndexNotifier.value = 0;
                      pushAndRemoveUntil(context, ChooseSignup());
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.h),
                  child: buttonWithBorder(
                    'Cancel',
                    fontSize: 14.sp,
                    height: 40.h,
                    buttonColor: AppColors.grey,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                    onTap: () {
                      Navigator.pop(cContext);
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
        ),
      ),
    );
  }
}
