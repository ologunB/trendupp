import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_drop_down.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class UpdateBank extends StatefulWidget {
  const UpdateBank({Key? key}) : super(key: key);

  @override
  _UpdateBankState createState() => _UpdateBankState();
}

class _UpdateBankState extends State<UpdateBank> {
  String? bank;
  TextEditingController number = TextEditingController();
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.lightBlack,
                      size: 16.h,
                    ),
                    SizedBox(width: 6.h),
                    regularText(
                      'SETTINGS',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          regularText(
            'Update Bank\nAccount Details',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 24.h),
          isDone ? done() : process(),
          SizedBox(height: 32.h),
          buttonWithBorder(
            isDone ? 'Confirm Account Details' : 'Verify Account',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
            onTap: () {
              isDone = !isDone;
              setState(() {});
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget process() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDownButton(
          hintText: 'Bank Name',
          onChanged: (String? a) {
            bank = a;
            setState(() {});
            return bank!;
          },
          list: ['First Bank', 'GTBank'],
          value: bank,
        ),
        CustomTextField(
          hintText: 'Account Number',
          controller: number,
          maxLength: 10,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget done() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        regularText(
          'Account Name',
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        regularText(
          'Chiamaka Olubankole',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ],
    );
  }
}
