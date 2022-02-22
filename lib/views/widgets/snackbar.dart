import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
 import 'package:mms_app/views/widgets/text_widgets.dart';

void showSnackBar(BuildContext context, String title, String msg,
    {int duration = 6,
    Color color = AppColors.green,
    TextAlign align = TextAlign.start}) {
  final Flushbar<void> flushBar = Flushbar<void>(
    titleText: regularText(
      title,
      fontSize: 12.sp,
      color: AppColors.white,
      textAlign: align,
      fontWeight: FontWeight.w600,
    ),
    messageText: regularText(
      msg,
      fontSize: 11.sp,
      color: AppColors.white,
      textAlign: align,
      fontWeight: FontWeight.w400,
    ),
    flushbarStyle: FlushbarStyle.GROUNDED,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: duration),
    backgroundColor: title == 'Error' ? AppColors.red : color,
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}
