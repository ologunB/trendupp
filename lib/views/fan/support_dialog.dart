import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/fan/support_auth.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mms_app/views/widgets/utils.dart';

class SupportDialog extends StatefulWidget {
  const SupportDialog({Key? key}) : super(key: key);

  @override
  _SupportDialogState createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  int? groupValue;
  String? selectedAmount;
  TextEditingController controller = TextEditingController();

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
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  Radio<int>(
                      value: 0,
                      activeColor: AppColors.red,
                      groupValue: groupValue,
                      onChanged: (a) {
                        groupValue = a;
                        setState(() {});
                      }),
                  regularText(
                    'ONE TIME',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                  SizedBox(width: 16.h),
                  Radio<int>(
                      value: 1,
                      activeColor: AppColors.red,
                      groupValue: groupValue,
                      onChanged: (a) {
                        groupValue = a;
                        setState(() {});
                      }),
                  regularText(
                    'MONTHLY',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(24.h),
                child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    children: list.map<Widget>((String e) {
                      return InkWell(
                        onTap: () {
                          selectedAmount = e;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.h),
                              color: selectedAmount == e
                                  ? AppColors.red
                                  : AppColors.lightRed),
                          padding: EdgeInsets.all(12.h),
                          child: regularText('₦ ' + e.toAmount(),
                              fontSize: 14.sp,
                              isOther: true,
                              fontWeight: FontWeight.w700,
                              color: selectedAmount == e
                                  ? AppColors.white
                                  : AppColors.red,
                              textAlign: TextAlign.center),
                        ),
                      );
                    }).toList(),
                    crossAxisSpacing: 8.h,
                    mainAxisSpacing: 16.h),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                    color: AppColors.lightRed),
                // padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(.4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.h),
                              bottomLeft: Radius.circular(8.h))),
                      padding: EdgeInsets.all(16.h),
                      child: regularText(
                        '₦',
                        fontSize: 16.sp,
                        isOther: true,
                        fontWeight: FontWeight.w700,
                        color: AppColors.red,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: CupertinoTextField(
                          padding: EdgeInsets.zero,
                          cursorColor: AppColors.textGrey,
                          cursorWidth: 1,
                          onChanged: (a) => setState(() {}),
                          placeholder: 'Other amount',
                          keyboardType: TextInputType.number,
                          controller: controller,
                          style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black),
                          placeholderStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: AppColors.red),
                          decoration: BoxDecoration(color: AppColors.lightRed),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: CustomTextField(
                  title: 'About me',
                  hintText: 'Say something nice....(optional)',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 24.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(cContext);
                    showDialog<AlertDialog>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) => SupportAuth(),
                    );
                  },
                  child: Container(

                    padding:
                        EdgeInsets.symmetric(horizontal: 40.h, vertical: 7.h),
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(6.h)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite,
                            color: AppColors.lightRed, size: 20.h),
                        SizedBox(width: 8.h),
                        regularText(
                          'Support Twyse',
                          fontSize: 12.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
      ),
    );
  }

  List<String> list = ['1000', '3000', '5000', '10000'];
}
