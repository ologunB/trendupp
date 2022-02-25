import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/creator_details.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

Widget creatorItem(BuildContext context, UserData data) {
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
          child: CachedNetworkImage(
            imageUrl: data.picture ?? "c",
            height: 40.h,
            width: 40.h,
            fit: BoxFit.cover,
            placeholder: (_, __) => Image.asset(
              'assets/images/person.png',
              height: 40.h,
              width: 40.h,
              fit: BoxFit.cover,
            ),
            errorWidget: (_, __, ___) => Image.asset(
              'assets/images/person.png',
              height: 40.h,
              width: 40.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        regularText(
          '${data.firstName} ${data.lastName}',
          fontSize: 12.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Expanded(
          child: regularText(
            data.about ?? '',
            fontSize: 8.sp,
            height: 1.8,
            color: AppColors.textGrey,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.h),
        InkWell(
          onTap: () {
            push(context, CreatorDetails(userData: data));
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
