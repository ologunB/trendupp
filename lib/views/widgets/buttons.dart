import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';

import 'text_widgets.dart';

Widget buttonWithBorder(
  String text, {
  Color? buttonColor,
  Color? textColor,
  Function()? onTap,
  Color? borderColor,
  FontWeight? fontWeight,
  double? fontSize,
  double? horiMargin,
  double? borderRadius,
  String? icon,
  double? height,
  double? width,
  bool busy = false,
  bool isActive = true,
}) {
  return InkWell(
    onTap: isActive ? (busy ? null : onTap) : null,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horiMargin ?? 0),
      decoration: BoxDecoration(
          color: isActive ? buttonColor : buttonColor!.withOpacity(.41),
          borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
          border: Border.all(
              width: .7.h,
              color: isActive
                  ? (borderColor ?? Colors.transparent)
                  : Color(0xffF6F6F6))),
      child: Center(
          child: busy
              ? SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  height: 20.h,
                  width: 20.h,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    regularText(
                      text,
                      color: isActive ? textColor : AppColors.grey,
                      fontSize: fontSize,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Image.asset(
                          'assets/images/$icon.png',
                          height: 24.h,
                           color: isActive ? textColor : AppColors.grey,
                        ),
                      )
                  ],
                )),
    ),
  );
}
