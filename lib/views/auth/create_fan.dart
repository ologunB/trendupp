import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
 import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class CreateFan extends StatefulWidget {
  const CreateFan({Key? key}) : super(key: key);

  @override
  _CreateFanState createState() => _CreateFanState();
}

class _CreateFanState extends State<CreateFan> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,        leading: SizedBox(),

        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
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
            'Complete your profile',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            hintText: 'First Name',
            controller: firstName,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            hintText: 'Last Name',
            controller: lastName,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 24.h),
          buttonWithBorder(
            'Continue',
            icon: 'go',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
            onTap: () => pushAndRemoveUntil(context, FanLayout()),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
