import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_drop_down.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class VerifyBank extends StatefulWidget {
  const VerifyBank({Key? key}) : super(key: key);

  @override
  _VerifyBankState createState() => _VerifyBankState();
}

class _VerifyBankState extends State<VerifyBank> {
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
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemCircle(AppColors.red, isDone: true),
                itemLine(AppColors.red),
                itemCircle(AppColors.red, isDone: true),
                itemLine(AppColors.red),
                itemCircle(AppColors.red),
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
            'Verify Your Bank  Account',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 10.h),
          regularText(
            'All funds paid to you by your supporters will\nbe sent to this account at your request',
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
          ),
          SizedBox(height: 32.h),
          isDone ? done() : process(),
          SizedBox(height: 24.h),
          buttonWithBorder(
            isDone ? 'Confirm Account Details' : 'Verify Account',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
            onTap: () {
              if (isDone) {
                showDialog<AlertDialog>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => congratsDialog(),
                );
                return;
              }
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

  Widget congratsDialog() {
    return Container(
      color: AppColors.black.withOpacity(.1),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: Column(
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
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/close.png',
                      width: 28.h,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/mark.png',
              width: 42.h,
              color: AppColors.green,
            ),
            SizedBox(height: 22.h),
            regularText(
              'Congratulations',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
            SizedBox(height: 8.h),
            regularText(
              'You’ve successfully created a profile.\nShare your page with your audience to\nget supporters',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              color: AppColors.textGrey,
            ),
            SizedBox(height: 24.h),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                    border: Border.all(color: AppColors.grey, width: 1.h),
                    color: AppColors.grey),
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo2.png',
                          height: 20.h,
                        ),
                        SizedBox(width: 12.h),
                        regularText(
                          'trendupp.com/randomname',
                          fontSize: 12.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textGrey,
                        ),
                      ],
                    ),
                    Image.asset('assets/images/tap.png', height: 24.h)
                  ],
                )),
            SizedBox(height: 32.h),
            regularText(
              'Share on',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/tw.png', width: 28.h),
                SizedBox(width: 30.h),
                Image.asset('assets/images/fb.png', width: 28.h),
                SizedBox(width: 30.h),
                Image.asset('assets/images/ws.png', width: 28.h),
              ],
            ),
            SizedBox(height: 24.h),
            InkWell(
              onTap: () => pushAndRemoveUntil(context, CreatorLayout()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
                decoration: BoxDecoration(
                    color: AppColors.lightRed,
                    borderRadius: BorderRadius.circular(20.h)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    regularText(
                      'View your page',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.red,
                    ),
                    SizedBox(width: 8.h),
                    Image.asset('assets/images/back.png', width: 18.h)
                  ],
                ),
              ),
            ),
            SizedBox(height: 70.h),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
      ),
    );
  }
}
