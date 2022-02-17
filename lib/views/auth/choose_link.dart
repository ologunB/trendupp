import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'fill_bio.dart';

class ChooseLink extends StatefulWidget {
  const ChooseLink({Key? key}) : super(key: key);

  @override
  _ChooseLinkState createState() => _ChooseLinkState();
}

class _ChooseLinkState extends State<ChooseLink> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            'Choose your link',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 10.h),
          regularText(
            'Pick a simple shareable link for your page.\nYou can always change this later',
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
          ),
          SizedBox(height: 24.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(
                    color: controller.text.isNotEmpty
                        ? AppColors.red
                        : AppColors.grey,
                    width: 1.h),
                color: AppColors.grey),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo2.png',
                  height: 20.h,
                ),
                Spacer(),
                regularText(
                  'trendupp.com/',
                  fontSize: 12.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoTextField(
                    padding: EdgeInsets.zero,
                    cursorColor: AppColors.textGrey,
                    cursorWidth: 1,
                    onChanged: (a) => setState(() {}),
                    placeholder: 'your name here',
                    controller: controller,
                    style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                    placeholderStyle: GoogleFonts.dmSans(
                        fontSize: 12.sp, color: AppColors.textGrey),
                    decoration: BoxDecoration(color: AppColors.grey),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/mark.png',
                  height: 20.h,
                  color: controller.text.isEmpty ? AppColors.grey1 : null,
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: buttonWithBorder(
              'Continue',
              buttonColor: AppColors.red,
              isActive: controller.text.isNotEmpty,
              fontSize: 16.sp,
              icon: 'go',
              height: 52.h,
              textColor: AppColors.white,
              fontWeight: FontWeight.w700,
              onTap: () => push(context, FillBio()),
            ),
          ),
        ],
      ),
    );
  }
}
