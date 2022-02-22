import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'buttons.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget(this.title,
      {this.desc, this.onAction, this.actionTitle, this.image});

  final String? title;
  final String? desc;
  final Function? onAction;
  final String? actionTitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    bool isOther = onAction != null;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Image.asset(
            image ?? 'assets/images/My Post.png',
            width: isOther ? 100 : 80.h,
          ),
          SizedBox(height: 8.h),
          regularText(
            title!,
            fontSize: isOther ? 18.sp : 14.sp,
            textAlign: TextAlign.center,
            fontWeight: isOther ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.black,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: regularText(
              desc ?? '',
              fontSize: isOther ? 14.sp : 12.sp,
              textAlign: TextAlign.center,
              color: isOther ? AppColors.black : AppColors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          if (actionTitle != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: buttonWithBorder(
                actionTitle!,
                buttonColor: AppColors.green,
                fontSize: 14.sp,
                height: 50.h,
                textColor: AppColors.white,
                fontWeight: FontWeight.w500,
                onTap: () async {
                  onAction!();
                },
              ),
            ),
        ],
      ),
    );
  }
}
