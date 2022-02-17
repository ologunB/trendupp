import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget regularText(String text,
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isName = false,
    double? height,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    bool isOther = false}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: true,
    style: isOther
        ? GoogleFonts.inter(
            color: color,
            letterSpacing: letterSpacing,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            decoration: decoration,
          )
        : GoogleFonts.dmSans(
            color: color,
            letterSpacing: letterSpacing,
            fontSize: fontSize,
            height: height,
            fontWeight: fontWeight,
            decoration: decoration,
          ),
  );
}

Widget itemCircle(Color color, {bool? isDone}) {
  return Container(
      height: 28.h,
      width: 28.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(28.h)),
      child: isDone == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  size: 20.h,
                  color: AppColors.white,
                ),
              ],
            )
          : null);
}

Widget itemText(String a, MainAxisAlignment alignment) {
  return Expanded(
      child: Row(
    mainAxisAlignment: alignment,
    children: [
      regularText(
        a,
        fontSize: 12.sp,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
        color: AppColors.textGrey,
      ),
    ],
  ));
}

Widget itemLine(Color color) {
  return Row(
    children: [
      Container(
        height: 2.h,
        width: 25.h,
        margin: EdgeInsets.only(left: 8.h),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3.h),
                bottomLeft: Radius.circular(3.h))),
      ),
      Container(
        height: 2.h,
        width: 25.h,
        margin: EdgeInsets.only(right: 8.h),
        decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(3.h),
                bottomRight: Radius.circular(3.h))),
      )
    ],
  );
}
