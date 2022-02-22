import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/auth/verify_bank.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_drop_down.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class UpdateBank extends StatefulWidget {
  const UpdateBank({Key? key}) : super(key: key);

  @override
  _UpdateBankState createState() => _UpdateBankState();
}

class _UpdateBankState extends State<UpdateBank> {
  String? bank, name;
  TextEditingController number = TextEditingController();
  bool isDone = false;

  @override
  void initState() {
    number.text = AppCache.getUser()!.accNumber!;
    bank = AppCache.getUser()!.bankName!;
    name = AppCache.getUser()!.accName!;
    super.initState();
  }

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
                    isDone ? done(model) : process(model),
                    SizedBox(height: 32.h),
                    buttonWithBorder(
                      isDone ? 'Confirm Account Details' : 'Verify Account',
                      buttonColor: AppColors.red,
                      fontSize: 16.sp,
                      height: 52.h,
                      busy: model.busy,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w700,
                      onTap: () async {
                        if (isDone) {
                          Map<String, String> data = {
                            "bankName": bank!,
                            "accName": model.resolvedName!,
                            "accNumber": number.text,
                          };
                          data.addAll(data);
                          bool res = await model.updateProfile(data, null);
                          if (res) {
                            isDone = false;
                            showSnackBar(context, 'Success',
                                "Bank Details have been updated");
                          }
                          return;
                        } else {
                          if (number.text.length == 10 && bank != null) {
                            Utils.offKeyboard();
                            String c = allNigerianBanks.firstWhere(
                                (e) => e['bank_name'] == bank)['bank_code'];
                            bool res =
                                await model.resolveAccount(number.text, c);
                            if (res) {
                              isDone = !isDone;
                              setState(() {});
                            }
                          } else {
                            return showSnackBar(
                                context, 'Error', 'Fill in all fields');
                          }
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ))));
  }

  Widget process(AuthViewModel model) {
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
          list: allNigerianBanks.map((e) => e['bank_name'].toString()).toList(),
          value: bank,
        ),
        CustomTextField(
          hintText: 'Account Number',
          controller: number,
          maxLength: 10,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        if (model.error != null && !model.busy)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: regularText(
              model.error!,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
      ],
    );
  }

  Widget done(AuthViewModel model) {
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
          model.resolvedName!,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ],
    );
  }
}
