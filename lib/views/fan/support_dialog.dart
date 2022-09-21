import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/views/fan/support_auth.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mms_app/views/widgets/utils.dart';

class SupportDialog extends StatefulWidget {
  const SupportDialog({Key? key, required this.creator, this.data})
      : super(key: key);

  final UserData creator;
  final Map<String, String>? data;

  @override
  _SupportDialogState createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  int frequency = 0;
  String? selectedAmount = '1000';
  TextEditingController amountController = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    if (widget.data != null) {
      Map<String, String> data = widget.data!;
      frequency = data['payment_plan'] == 'Monthly' ? 1 : 0;
      message.text = data['message']!;

      if (list.contains(data['amount']!)) {
        selectedAmount = data['amount'];
      } else {
        selectedAmount = null;
        amountController.text = data['amount']!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext cContext) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: GestureDetector(
        onTap: Utils.offKeyboard,
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
                      errorWidget:
                          (BuildContext context, String url, dynamic error) =>
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
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          frequency = 0;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              frequency == 0
                                  ? Icons.radio_button_checked_outlined
                                  : Icons.radio_button_off_outlined,
                              color: AppColors.red,
                            ),
                            SizedBox(width: 4.h),
                            regularText(
                              'ONE TIME',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightBlack,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.h),
                      InkWell(
                        onTap: () {
                          frequency = 1;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              frequency == 1
                                  ? Icons.radio_button_checked_outlined
                                  : Icons.radio_button_off_outlined,
                              color: AppColors.red,
                            ),
                            SizedBox(width: 4.h),
                            regularText(
                              'MONTHLY',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
                    child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: list.map<Widget>((String e) {
                          return InkWell(
                            onTap: () {
                              selectedAmount = e;
                              amountController.text = '';
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
                        mainAxisSpacing: 8.h),
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
                              maxLength: 5,
                              onChanged: (a) {
                                selectedAmount = null;
                                setState(() {});
                              },
                              placeholder: 'Other amount',
                              keyboardType: TextInputType.number,
                              controller: amountController,
                              style: GoogleFonts.dmSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.red),
                              placeholderStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: AppColors.red),
                              decoration:
                                  BoxDecoration(color: AppColors.lightRed),
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
                      title: 'Send @${widget.creator.brandName} a message',
                      hintText: 'Say something nice....(optional)',
                      textInputType: TextInputType.text,
                      maxLines: 3,
                      controller: message,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 24.h),
                    child: InkWell(
                      onTap: () {
                        if (amountController.text.isNotEmpty ||
                            selectedAmount != null) {
                          if ((double.tryParse(amountController.text) ?? 0) >
                              50000) {
                            return showSnackBar(context, 'Error',
                                'Amount cannot be more than NGN50,000');
                          }
                          Map<String, String> data = {
                            "amount": selectedAmount ?? amountController.text,
                            "payment_plan":
                                frequency == 0 ? "One-Time" : "Monthly",
                            "creatorId": widget.creator.id.toString(),
                            "message": message.text
                          };
                          Navigator.pop(cContext);
                          showDialog<AlertDialog>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) =>
                                SupportAuth(data, widget.creator),
                          );
                        } else {
                          showSnackBar(
                              context, 'Info', 'Select/Input an Amount');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.h, vertical: 7.h),
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
                              'Support @${widget.creator.brandName}',
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.h)),
          ),
        ),
      ),
    );
  }

  List<String> list = ['1000', '3000', '5000', '10000'];
}
