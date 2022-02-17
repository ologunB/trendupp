import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/choose_link.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'create_fan.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({Key? key}) : super(key: key);

  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  String? type;

  @override
  Widget build(BuildContext context) {
    double w = ScreenUtil.defaultSize.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemCircle(AppColors.red),
                itemLine(AppColors.red),
                itemCircle(AppColors.grey1),
                itemLine(AppColors.grey1),
                itemCircle(AppColors.grey1),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemText('Are you a\ncreator?', MainAxisAlignment.start),
                itemText('User Details', MainAxisAlignment.center),
                itemText('Bank Account\nDetails', MainAxisAlignment.end),
              ],
            ),
          ),
          SizedBox(height: 44.h),
          regularText(
            'Are you a Creator?',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['creator', 'fan']
                .map((e) => Container(
                      margin: EdgeInsets.all(8.h),
                      child: InkWell(
                        onTap: () {
                          type = e;
                          setState(() {});
                        },
                        child: Container(
                          height: (w / 2) - 16.h,
                          width: (w / 2) - 16.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.h),
                              border: Border.all(
                                  color: type == e
                                      ? AppColors.red
                                      : AppColors.grey,
                                  width: 1.h),
                              color: AppColors.grey),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/$e.png',
                                height: 70.h,
                                width: 70.h,
                              ),
                              SizedBox(height: 15.h),
                              regularText(
                                (e == 'fan' ? '' : 'Yes, ') + 'I’m a $e',
                                fontSize: 12.sp,
                                textAlign: TextAlign.center,
                                color: type == e
                                    ? AppColors.red
                                    : AppColors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 34.h),
          if (type != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: buttonWithBorder(
                'Continue',
                buttonColor: AppColors.red,
                fontSize: 16.sp,
                height: 52.h,
                textColor: AppColors.white,
                fontWeight: FontWeight.w700,
                onTap: () {
                  push(context, type == 'fan' ? CreateFan() : ChooseLink());
                },
              ),
            ),
        ],
      ),
    );
  }
}
