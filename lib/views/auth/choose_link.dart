import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import '../base_view.dart';
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
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => GestureDetector(
              onTap: Utils.offKeyboard,
              child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  centerTitle: true,
                  leading: SizedBox(),
                  title: Image.asset('assets/images/logo.png', height: 32.h),
                ),
                body: ListView(
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          itemCircle(AppColors.red, isDone: true),
                          itemLine(AppColors.red),
                          itemCircle(AppColors.red),
                          itemLine(AppColors.grey1),
                          itemCircle(AppColors.grey1),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          itemText(
                              'Are you a\ncreator?', MainAxisAlignment.start),
                          itemText('User Details', MainAxisAlignment.center),
                          itemText(
                              'Bank Account\nDetails', MainAxisAlignment.end),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.h, vertical: 16.h),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                            height: 20.h,
                          ),
                          SizedBox(width: 10.h),
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
                              onChanged: (a) {
                                if (a.length > 3) {
                                  model.checkLink(a);
                                } else {
                                  model.isVerified = false;
                                }
                                setState(() {});
                              },
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
                          SizedBox(width: 10.h),
                          Image.asset(
                            'assets/images/mark.png',
                            height: 20.h,
                            color: !model.isVerified ? AppColors.grey1 : null,
                          )
                        ],
                      ),
                    ),
                    if (!model.isVerified)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.h, vertical: 8.h),
                        child: regularText(
                          controller.text.length <= 3
                              ? 'Your username should be more than 3 characters'
                              : !model.isVerified && !model.busy
                                  ? model.error ?? ''
                                  : "",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.red,
                        ),
                      ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: buttonWithBorder(
                        'Continue',
                        buttonColor: AppColors.red,
                        isActive: model.isVerified,
                        fontSize: 16.sp,
                        icon: 'go',
                        height: 52.h,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w700,
                        onTap: () =>
                            push(context, FillBio(link: controller.text)),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ));
  }
}
