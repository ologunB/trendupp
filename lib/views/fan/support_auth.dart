import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/fan/support_done.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:http/http.dart';
import 'package:mms_app/views/widgets/webview_screen.dart';
import '../base_view.dart';

class SupportAuth extends StatefulWidget {
  const SupportAuth(this.data, this.creator);

  final Map<String, String> data;
  final UserData creator;

  @override
  _SupportAuthState createState() => _SupportAuthState();
}

class _SupportAuthState extends State<SupportAuth> {
  @override
  void initState() {
    first = TextEditingController(text: AppCache.getUser()?.firstName);
    last = TextEditingController(text: AppCache.getUser()?.lastName);
    email = TextEditingController(text: AppCache.getUser()?.email);
    super.initState();
  }

  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

                                      showDialog<AlertDialog>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            SupportDialog(
                                          creator: widget.creator,
                                          data: widget.data,
                                        ),
                                      );
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
                                imageUrl: widget.creator.picture ?? 'a',
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
                              'Support @${widget.creator.brandName}',
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
        final url = Utils.getBaseUrl() + 'payments';
        final uri = Uri.parse(url);
        try {
          model.setBusy(true);
          final response = await Client().post(uri,
              headers: {
                HttpHeaders.authorizationHeader: Utils.ravePublicKey,
                HttpHeaders.contentTypeHeader: 'application/json'
              },
              body: jsonEncode({
                "tx_ref": reference,
                "publicKey": Utils.ravePublicKey,
                "amount": data1['amount']!,
                "currency": 'NGN',
                "payment_options": "ussd, card, barter, payattitude",
                "payment_plan":
                    widget.data['payment_plan'] == 'Monthly' ? 'monthly' : null,
                "redirect_url": Utils.DEFAULT_URL,
                "customer": {
                  "email": email.text,
                  "phonenumber": '01838838343',
                  "name": first.text + ' ' + last.text,
                },
                "customizations": {
                  "title": "TrendUpp",
                  "description": "Support Creator",
                  "logo":
                      'https://firebasestorage.googleapis.com/v0/b/triviablog-78fd9.appspot.com/o/icon.png?alt=media&token=7687066d-d003-4f88-986c-e4941a9554ab'
                }
              }));
          final responseBody = json.decode(response.body);
          Logger().d(responseBody);
          model.setBusy(false);

          if (responseBody["status"] == "error") {
            throw responseBody["message"] ??
                "An unexpected error occurred. Please try again.";
          }
          dynamic msg = await Navigator.push(
            this.context,
            CupertinoPageRoute<dynamic>(
              builder: (BuildContext context) => WebviewScreen(
                url: responseBody['data']['link'],
              ),
            ),
          );
          if (msg != null) {
            if (msg[0]) {
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
              throw msg[1];
            }
          }
        } catch (error) {
          print(error);
          model.setBusy(false);
          showSnackBar(context, 'Error', error.toString());
        }
      }
    }
  }
}
