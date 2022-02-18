import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class UpdateLink extends StatefulWidget {
  const UpdateLink({Key? key}) : super(key: key);

  @override
  _UpdateLinkState createState() => _UpdateLinkState();
}

class _UpdateLinkState extends State<UpdateLink> {
  TextEditingController controller = TextEditingController(text: 'aa');

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
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.h),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.h),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
                ]),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              physics: ClampingScrollPhysics(),
              children: [
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
                SizedBox(height: 36.h),
                regularText(
                  'Choose your link',
                  fontSize: 24.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                SizedBox(height: 10.h),
                regularText(
                  'Pick a simple shareable link for your page.',
                  fontSize: 12.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGrey,
                ),
                SizedBox(height: 24.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      border: Border.all(
                          color: controller.text.isNotEmpty
                              ? AppColors.red
                              : AppColors.grey,
                          width: 1.h),
                      color: AppColors.grey),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
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
                buttonWithBorder(
                  'Update Link',
                  buttonColor: AppColors.red,
                  isActive: controller.text.isNotEmpty,
                  fontSize: 16.sp,
                  height: 52.h,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
