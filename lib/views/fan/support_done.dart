import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/login.dart';
 import 'package:mms_app/views/widgets/text_widgets.dart';

class SupportDone extends StatelessWidget {
  const SupportDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = true;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leading: SizedBox(),
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo2.png', height: 32.h),
                Spacer(),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 30.h),
            Container(
              padding: EdgeInsets.all(16.h),
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/mark.png',
                    height: 42.h,
                    color: AppColors.green,
                  ),
                  SizedBox(height: 24.h),
                  regularText(
                    'Thank you for supporting Twyse',
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  isLoggedIn
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'You can ',
                            style: GoogleFonts.dmSans(
                              color: AppColors.textGrey,
                              height: 1.8,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                  text: 'log in',
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.red,
                                    fontSize: 15.sp,
                                    height: 1.8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      push(context, LoginView());
                                    }),
                              TextSpan(
                                text: ' to track your support to creators',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.textGrey,
                                  fontSize: 15.sp,
                                  height: 1.8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : regularText(
                          'An account has been created for you to track your support to creators.\nThe log in details has been sent to your email',
                          fontSize: 14.sp,
                          height: 1.8,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textGrey,
                        ),
                  SizedBox(height: 24.h),
                //  if (isLoggedIn)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.h, vertical: 7.h),
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(6.h)),
                            child: regularText(
                              'Go back to twyse page',
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ));
  }
}
