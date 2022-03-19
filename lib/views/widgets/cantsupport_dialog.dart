import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'buttons.dart';

class CantSupportDialog extends StatefulWidget {
  const CantSupportDialog({Key? key, this.user}) : super(key: key);
  final UserData? user;

  @override
  _CantSupportDialogState createState() => _CantSupportDialogState();
}

class _CantSupportDialogState extends State<CantSupportDialog> {
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
                Image.asset(
                  'assets/images/frown.png',
                  width: 45.h,
                ),
                SizedBox(height: 20.h),
                regularText(
                    'We’re sorry! You need a fan\naccount to support a creator',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    textAlign: TextAlign.center),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.h, vertical: 40.h),
                  child: buttonWithBorder(
                    'Go back to ${widget.user?.brandName} page',
                    buttonColor: AppColors.red,
                    fontSize: 14.sp,
                    height: 40.h,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                    onTap: () {
                      Navigator.pop(cContext);
                    },
                  ),
                ),
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
