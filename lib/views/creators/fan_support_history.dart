import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/models/fan_payment_history.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class FanSupportHistory extends StatefulWidget {
  const FanSupportHistory(this.support);

  final Supporters support;

  @override
  _FanSupportHistoryState createState() => _FanSupportHistoryState();
}

class _FanSupportHistoryState extends State<FanSupportHistory> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StatViewModel>(
        onModelReady: (m) =>
            m.creatorGetFanSupportHistory(widget.support.email!),
        builder: (_, StatViewModel historyModel, __) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                leadingWidth: 0,
                backgroundColor: Colors.transparent,
                titleSpacing: 0,
                centerTitle: true,
                leading: SizedBox(),
                title: Image.asset('assets/images/logo.png', height: 32.h),
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
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
                              'BACK',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.h),
                        child: CachedNetworkImage(
                          imageUrl:
                              historyModel.fanSupportHistory?.user?.picture ??
                                  'a',
                          height: 50.h,
                          width: 50.h,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Image.asset(
                            'assets/images/person.png',
                            height: 50.h,
                            width: 50.h,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Image.asset(
                            'assets/images/person.png',
                            height: 50.h,
                            width: 50.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                              '${widget.support.firstName} ${widget.support.lastName}',
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            regularText(
                              '${widget.support.email}',
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
                            'SUPPORT HISTORY',
                            fontSize: 12.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        historyModel.busy
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15.h),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(.1),
                                      highlightColor: Colors.white60,
                                      child: Container(
                                        height: 60.h,
                                        margin: EdgeInsets.only(top: 8.h),
                                        width: ScreenUtil.defaultSize.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(5.h),
                                        ),
                                      ));
                                })
                            : historyModel.fanSupportHistory == null
                                ? ErrorOccurredWidget(
                                    error: historyModel.error,
                                    onPressed: () {
                                      historyModel.creatorGetFanSupportHistory(
                                          widget.support.email!);
                                    },
                                  )
                                : historyModel
                                        .fanSupportHistory!.history!.isEmpty
                                    ? AppEmptyWidget('Support History is empty')
                                    : ListView.separated(
                                        separatorBuilder: (_, __) {
                                          return Divider(
                                              color: AppColors.textGrey
                                                  .withOpacity(.4),
                                              height: 2.h);
                                        },
                                        itemCount: historyModel
                                            .fanSupportHistory!.history!.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext ctx, i) {
                                          FanHistoryModel fanModel =
                                              historyModel.fanSupportHistory!
                                                  .history![i];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h,
                                                horizontal: 24.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                regularText(
                                                  '₦ ${fanModel.amount!.toAmount()}',
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  isOther: true,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.h),
                                                  child: regularText(
                                                    DateFormat('MMM dd, yyyy')
                                                            .format(DateTime
                                                                .parse(fanModel
                                                                    .createdAt!)) +
                                                        ' at ' +
                                                        DateFormat(' hh:mm a')
                                                            .format(DateTime
                                                                .parse(fanModel
                                                                    .createdAt!)),
                                                    fontSize: 12.sp,
                                                    color: AppColors.textGrey,
                                                  ),
                                                ),
                                                regularText(
                                                  '${fanModel.paymentPlan}',
                                                  fontSize: 11.sp,
                                                  color: AppColors.textGrey,
                                                  isOther: true,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                regularText(
                                                  '${fanModel.message}',
                                                  fontSize: 12.sp,
                                                  color: AppColors.black,
                                                  isOther: true,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ));
  }
}
