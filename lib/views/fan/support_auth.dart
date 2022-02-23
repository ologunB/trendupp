import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/fan/support_done.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class SupportAuth extends StatefulWidget {
  const SupportAuth(this.data, this.creator);

  final Map<String, String> data;
  final UserData creator;

  @override
  _SupportAuthState createState() => _SupportAuthState();
}

class _SupportAuthState extends State<SupportAuth> {
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    first = TextEditingController(text: AppCache.getUser()?.firstName);
    last = TextEditingController(text: AppCache.getUser()?.lastName);
    email = TextEditingController(text: AppCache.getUser()?.email);
    super.initState();
  }

  @override
  Widget build(BuildContext cContext) {
    return BaseView<StatViewModel>(
        onModelReady: (m) => m,
        builder: (_, StatViewModel model, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Form(
                key: formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: AppColors.textGrey.withOpacity(.1),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      insetPadding: EdgeInsets.zero,
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: ScreenUtil.defaultSize.width - 8.h,
                              padding: EdgeInsets.only(top: 10.h, right: 10.h),
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
                              child: CachedNetworkImage(
                                imageUrl: widget.creator.picture?? 'a',
                                width: 54.h,
                                height: 54.h,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Image.asset(
                                  'assets/images/person.png',
                                  width: 54.h,
                                  height: 54.h,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (BuildContext context, String url,
                                        dynamic error) =>
                                    Image.asset(
                                  'assets/images/person.png',
                                  width: 54.h,
                                  height: 54.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            regularText(
                              'Support ${widget.creator.firstName} ${widget.creator.firstName}',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: CustomTextField(
                                hintText: 'Email',
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: email,
                                validator: Utils.validateEmail,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: CustomTextField(
                                hintText: 'First Name',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: first,
                                validator: (a) {
                                  return Utils.isValidName(a, '"Last Name"', 2);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: CustomTextField(
                                hintText: 'Last Name',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: last,
                                validator: (a) {
                                  return Utils.isValidName(a, '"Last Name"', 2);
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.h, vertical: 6.h),
                              child: Row(
                                children: [
                                  regularText(
                                    'Amount',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: Row(
                                children: [
                                  regularText(
                                    '₦ ${widget.data['amount'].toString().toAmount()} ',
                                    fontSize: 12.sp,
                                    isOther: true,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                  regularText(
                                    widget.data['payment_plan']
                                        .toString()
                                        .toLowerCase(),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.h, vertical: 16.h),
                              child: buttonWithBorder('Pay with Flutterwave',
                                  buttonColor: AppColors.red,
                                  fontSize: 14.sp,
                                  height: 40.h,
                                  busy: model.busy,
                                  textColor: AppColors.white,
                                  fontWeight: FontWeight.w700, onTap: () {
                                onTap(model, cContext);
                              }),
                            ),
                            Image.asset(
                              'assets/images/payment.png',
                              height: 80.h,
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.h)),
                    ),
                  ),
                ))));
  }

  onTap(StatViewModel model, BuildContext cContext) async {
    autoValidate = true;
    setState(() {});
    if (formKey.currentState!.validate()) {
      Utils.offKeyboard();
      Map<String, String> data1 = {
        "email": email.text,
        "firstName": first.text,
        "lastName": last.text,
      };
      data1.addAll(widget.data);
      String? reference = await model.initPayment(data1);
      if (reference != null) {
        // pay now
        final Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: context,
          encryptionKey: Utils.raveEncryptionKey,
          publicKey: Utils.ravePublicKey,
          currency: FlutterwaveCurrency.NGN,
          amount: data1['amount']!,
          email: email.text,
          fullName: first.text + ' ' + last.text,
          txRef: reference,
          isDebugMode: false,
          phoneNumber: "0123456789",
          acceptCardPayment: true,
          acceptUSSDPayment: true,
          acceptAccountPayment: true,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: true,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false,
        );

        try {
          final ChargeResponse? response =
              await flutterwave.initializeForUiPayments();
          if (response == null) {
            showSnackBar(
                context, 'Error', 'User didn\'t complete the transaction');
          } else {
            if (response.status == FlutterwaveConstants.SUCCESSFUL) {
              Map<String, String> data2 = {
                "status": "approved",
                "reference": reference,
                "creatorEmail": widget.creator.email!
              };
              bool res = await model.confirmPayment(data2);
              if (res) {
                bool hasAccount = await model.socialCheck(data1);
                Navigator.pop(cContext);
                push(context, SupportDone(widget.creator, hasAccount));
              }
            } else {
              // check message
              print(response.message);

              // check status
              print(response.status);

              // check processor error
              print(response.data!.processorResponse);
              showSnackBar(context, 'Error', response.message!);
            }
          }
        } catch (error) {
          print(error);
        }
      }
    }
  }
}
