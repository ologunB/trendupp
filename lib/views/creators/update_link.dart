import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class UpdateLink extends StatefulWidget {
  const UpdateLink({Key? key}) : super(key: key);

  @override
  _UpdateLinkState createState() => _UpdateLinkState();
}

class _UpdateLinkState extends State<UpdateLink> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = AppCache.getUser()!.userName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => m.toVerify(true),
        builder: (_, AuthViewModel model, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Scaffold(
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
                              color: AppColors.grey,
                              blurRadius: 6,
                              spreadRadius: 2)
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
                        SizedBox(height: 30.h),
                        Container(
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
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey),
                                  decoration:
                                      BoxDecoration(color: AppColors.grey),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              model.busy
                                  ? SizedBox(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                AppColors.red),
                                      ),
                                      height: 15.h,
                                      width: 15.h,
                                    )
                                  : Image.asset(
                                      'assets/images/mark.png',
                                      height: 20.h,
                                      color: !model.isVerified
                                          ? AppColors.grey1
                                          : null,
                                    )
                            ],
                          ),
                        ),
                        if (!model.isVerified)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
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
                        SizedBox(height: 20.h),
                        BaseView<AuthViewModel>(
                            onModelReady: (m) => null,
                            builder: (_, AuthViewModel updateModel, __) =>
                                buttonWithBorder('Update Link',
                                    buttonColor: AppColors.red,
                                    isActive: model.isVerified,
                                    fontSize: 16.sp,
                                    height: 52.h,
                                    busy: updateModel.busy,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    onTap: () async {
                                  if (controller.text.length > 3) {
                                    Utils.offKeyboard();

                                    Map<String, String> data = {
                                      "userName": controller.text,
                                    };

                                    bool res = await updateModel.updateProfile(
                                        data, null);
                                    if (res) {
                                      showSnackBar(context, 'Success',
                                          'Your Link has been updated successfully');
                                    }
                                  }
                                })),
                        SizedBox(height: 36.h),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
