import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import 'choose_signup.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _index = 0;

  PageController controller = PageController();
  Image img0 = Image.asset(
    'assets/images/onboard0.png',
    fit: BoxFit.cover,
    gaplessPlayback: true,
  );
  Image img1 = Image.asset(
    'assets/images/onboard1.png',
    fit: BoxFit.cover,
    gaplessPlayback: true,
  );
  Image img2 = Image.asset(
    'assets/images/onboard2.png',
    fit: BoxFit.cover,
    gaplessPlayback: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.offKeyboard();
    return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => Scaffold(
            backgroundColor: _index == 0
                ? Color(0xffFFBFDD)
                : _index == 1
                    ? Color(0xffFFBFDD)
                    : Color(0xffFEEA6B),
            body: SafeArea(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    onPageChanged: (a) {
                      _index = a;
                      setState(() {});
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return img0;
                        case 1:
                          return img1;
                      }
                      return img2;
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.h, right: 30.h, left: 30.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 22.h,
                              margin: EdgeInsets.only(bottom: 20.h),
                              child: ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 15.h,
                                          height: 15.h,
                                          margin: EdgeInsets.all(3.h),
                                          decoration: BoxDecoration(
                                            color: _index == index
                                                ? Colors.black
                                                : Colors.transparent,
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(30.h),
                                          ),
                                          padding: EdgeInsets.all(
                                              _index == index ? 0 : 4.h),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(height: 5.h),
                            buttonWithBorder('LOG IN',
                                buttonColor: Colors.transparent,
                                fontSize: 16.sp,
                                borderRadius: 55.sp,
                                height: 61.h,
                                width: 290.h,
                                textColor: AppColors.black,
                                borderColor: AppColors.white,
                                fontWeight: FontWeight.w700, onTap: () {
                              pushReplacement(context, ChooseSignup());
                            }),
                            SizedBox(height: 14.h),
                            buttonWithBorder('SIGN UP',
                                buttonColor: Colors.white,
                                fontSize: 16.sp,
                                borderRadius: 55.sp,
                                height: 61.h,
                                width: 290.h,
                                textColor: AppColors.black,
                                borderColor: AppColors.white,
                                fontWeight: FontWeight.w700, onTap: () {
                              pushReplacement(context, ChooseSignup());
                            }),
                          ],
                        ),
                      ))
                ],
              ),
            )));
  }
}
