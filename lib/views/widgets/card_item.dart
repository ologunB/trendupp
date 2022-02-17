import 'package:flutter/cupertino.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

Widget cardItem(String img, String a, String b, Color pri, Color sec) {
  return Container(
    padding: EdgeInsets.all(18.h),
    margin: EdgeInsets.only(bottom: 16.h),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8.h), color: pri),
    child: Row(
      children: [
        Image.asset(
          'assets/images/$img.png',
          height: 42.h,
        ),
        SizedBox(width: 16.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            regularText(
              a,
              fontSize: 24.sp,
              color: sec,
              isOther: true,
              fontWeight: FontWeight.w700,
            ),
            regularText(
              b,
              fontSize: 12.sp,
              color: AppColors.lightBlack,
              fontWeight: FontWeight.w500,
            ),
          ],
        )
      ],
    ),
  );
}
