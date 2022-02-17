import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({this.error = 'An error occurred', this.onPressed});

  final String error;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
     return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/images/error-img.png', height: 110.h),
          SizedBox(height: 25.h),
          regularText(error ,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.red),
          SizedBox(height: 25.h),
          if (onPressed != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6.h),
                        border: Border.all(color: AppColors.darkBlue)),
                    child: regularText('TRY AGAIN',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBlue),
                  ),
                )
              ],
            )
        ],
      ),
    ));
  }
}
