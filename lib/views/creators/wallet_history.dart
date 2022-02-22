import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/stat_api.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../base_view.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StatViewModel>(
        onModelReady: (m) => m.paymentHistory(),
        builder: (_, StatViewModel model, __) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
              children: [
                Container(
                    padding: EdgeInsets.all(18.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.h),
                        color: AppColors.lightRed),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/wallet2.png',
                              height: 42.h,
                            ),
                            SizedBox(width: 16.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regularText(
                                  '₦22,500',
                                  fontSize: 24.sp,
                                  isOther: true,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                                regularText(
                                  'Current Earning',
                                  fontSize: 10.sp,
                                  color: AppColors.textGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 24.h),
                        regularText(
                          'Minimum Payout: ₦10,000',
                          fontSize: 12.sp,
                          isOther: true,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 16.h),
                        buttonWithBorder(
                          'Request Pay Out',
                          buttonColor: AppColors.green,
                          //  isActive: controller.text.isNotEmpty,
                          fontSize: 12.sp,
                          height: 40.h,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 24.h),
                        regularText(
                          'Your current earning must hit the minimum payout\nfor you to activate payout.',
                          fontSize: 10.sp,
                          textAlign: TextAlign.center,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    )),
                SizedBox(height: 16.h),
                cardItem('wallet1', '₦22,500', 'Current Earning',
                    Color(0xffEEEDEE), Color(0xff6E757C)),
                SizedBox(height: 16.h),
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
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: regularText(
                          'PAYOUT HISTORY',
                          fontSize: 14.sp,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      model.busy
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 15.h),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(.1),
                                    highlightColor: Colors.white60,
                                    child: Container(
                                      height: 80.h,
                                      margin: EdgeInsets.only(top: 8.h),
                                      width: ScreenUtil.defaultSize.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.7),
                                        borderRadius:
                                            BorderRadius.circular(5.h),
                                      ),
                                    ));
                              })
                          : model.allPaymentHistory == null
                              ? ErrorOccurredWidget(
                                  error: model.error,
                                  onPressed: model.paymentHistory,
                                )
                              : model.allPaymentHistory!.isEmpty
                                  ? AppEmptyWidget('No payout yet')
                                  : ListView.separated(
                                      separatorBuilder: (_, __) {
                                        return Divider(
                                            color: AppColors.textGrey
                                                .withOpacity(.4),
                                            height: 2.h);
                                      },
                                      itemCount:
                                          model.allPaymentHistory!.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext ctx, index) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h,
                                                horizontal: 24.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                regularText(
                                                  '₦5,000',
                                                  fontSize: 14.sp,
                                                  isOther: true,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.h),
                                                  child: regularText(
                                                    'Jun 10, 2021 at 02:12 PM',
                                                    fontSize: 12.sp,
                                                    color: AppColors.textGrey,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.h,
                                                      vertical: 5.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.h),
                                                      color: index.isEven
                                                          ? AppColors.green
                                                          : Color(0xffF09949)),
                                                  child: regularText(
                                                    index.isEven
                                                        ? 'Payout Successful'
                                                        : 'Pending Payout',
                                                    fontSize: 8.sp,
                                                    color: index.isEven
                                                        ? AppColors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ));
  }
}
