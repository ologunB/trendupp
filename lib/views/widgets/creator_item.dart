import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/creator_details.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

Widget creatorItem(BuildContext context, dynamic data) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 22.h),
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
      ],
      borderRadius: BorderRadius.circular(8.h),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40.h),
          child: Image.asset(
            'assets/images/placeholder.png',
            height: 40.h,
          ),
        ),
        SizedBox(height: 6.h),
        regularText(
          'Richard Bowers',
          fontSize: 12.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        regularText(
          'Travel & Lifestyle Youtuber living in Lagos, Nigeria. I create content....',
          fontSize: 8.sp,
          height: 1.8,
          color: AppColors.textGrey,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        InkWell(
          onTap: () {
            push(context, CreatorDetails());
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
            decoration: BoxDecoration(
              color: AppColors.lightRed,
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: regularText(
              'VIEW CREATOR',
              fontSize: 10.sp,
              color: AppColors.red,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
