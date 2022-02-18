import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/support_done.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class SupportAuth extends StatefulWidget {
  const SupportAuth({Key? key}) : super(key: key);

  @override
  _SupportAuthState createState() => _SupportAuthState();
}

class _SupportAuthState extends State<SupportAuth> {
  @override
  Widget build(BuildContext cContext) {
    return Container(
      color: AppColors.darkBlue.withOpacity(.1),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(27.h),
                child: Image.asset(
                  'assets/images/placeholder.png',
                  width: 54.h,
                  height: 54.h,
                ),
              ),
              SizedBox(height: 16.h),
              regularText(
                'Support Twyse Ereme',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: CustomTextField(
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: CustomTextField(
                  hintText: 'First Name',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: CustomTextField(
                  hintText: 'Last Name',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 6.h),
                child: Row(
                  children: [
                    regularText(
                      'Amount',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGrey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Row(
                  children: [
                    regularText(
                      '₦ 10,000',
                      fontSize: 12.sp,
                      isOther: true,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    regularText(
                      ' monthly',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGrey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(cContext);
                    push(context, SupportDone());
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.h, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(6.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          regularText(
                            'Pay with Flutterwave',
                            fontSize: 14.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ),
              ),
              Image.asset(
                'assets/images/payment.png',
                height: 80.h,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
      ),
    );
  }
}
