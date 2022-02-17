import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/post_details.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

Widget creatorPost(BuildContext context, int index) {
  return InkWell(
    onTap: () {
      if (index % 3 == 2) {
        showDialog<AlertDialog>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => SupportDialog(),
        );
        return;
      }
      push(context, PostDetail());
    },
    child: Container(
      padding: EdgeInsets.all(16.h),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
        ],
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.h),
                child: Image.asset(
                  'assets/images/placeholder.png',
                  height: 40.h,
                ),
              ),
              SizedBox(width: 13.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText(
                      'Twyse Ereme',
                      fontSize: 12.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    regularText(
                      'March 2, 2022',
                      fontSize: 10.sp,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),
          index % 3 == 2
              ? Container(
                  height: 172.h,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.h),
                        child: Image.asset(
                          'assets/images/hidden.png',
                          height: 172.h,
                          width: ScreenUtil.defaultSize.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(),
                          Image.asset(
                            'assets/images/locked.png',
                            height: 40.h,
                          ),
                          SizedBox(height: 16.h),
                          regularText(
                            'This post is for supporters',
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.h, vertical: 7.h),
                            decoration: BoxDecoration(
                                color: AppColors.textGrey,
                                borderRadius: BorderRadius.circular(6.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.favorite,
                                    color: AppColors.grey1, size: 20.h),
                                SizedBox(width: 8.h),
                                regularText(
                                  'Support Twyse',
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    height: 172.h,
                    width: ScreenUtil.defaultSize.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
          SizedBox(height: 16.h),
          regularText(
            'We went on tour in Cairo, Egypt',
            fontSize: 16.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          regularText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu faucibus augue eu euismod congue nunc, urna. Cursus ac, viverra sit varius nisi, ultricies.',
            fontSize: 12.sp,
            height: 1.8,
            color: AppColors.textGrey,
          ),
        ],
      ),
    ),
  );
}
