import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/fan/fan_layout.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class CreateFan extends StatefulWidget {
  const CreateFan({Key? key}) : super(key: key);

  @override
  _CreateFanState createState() => _CreateFanState();
}

class _CreateFanState extends State<CreateFan> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => Form(
              key: formKey,
              autovalidateMode: autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
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
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
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
                      validator: (a) {
                        return Utils.isValidName(a, '"First Name"', 2);
                      },
                    ),
                    CustomTextField(
                      hintText: 'Last Name',
                      controller: lastName,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (a) {
                        return Utils.isValidName(a, '"Last Name"', 2);
                      },
                    ),
                    SizedBox(height: 24.h),
                    buttonWithBorder(
                      'Continue',
                      icon: 'go',
                      buttonColor: AppColors.red,
                      fontSize: 16.sp,
                      height: 52.h,
                      busy: model.busy,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w700,
                      onTap: () {
                        autoValidate = true;
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          Utils.offKeyboard();
                          Map<String, String> data = {
                            'firstName': firstName.text,
                            'lastName': lastName.text,
                            'onboardingStep': '4',
                            'userType': 'fan',
                          };
                          model.updateProfile(data, FanLayout());
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ));
  }
}
