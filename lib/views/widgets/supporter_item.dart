import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/creators/fan_support_history.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class SupporterItem extends StatelessWidget {
  const SupporterItem(this.support);

  final Supporters support;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  regularText(
                    '${support.firstName} ${support.lastName}',
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: regularText(
                      Utils.stringToDate(support.createdAt!),
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: regularText(
                      '${support.email}',
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                  regularText(
                    '₦ ${support.amount!.toAmount()}',
                    fontSize: 12.sp,
                    isOther: true,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.h),
            PopupMenuButton(
                onSelected: (int a) {
                  if (a == 0) {
                    push(context, FanSupportHistory(support));
                  }
                },
                child: Image.asset(
                  'assets/images/more.png',
                  height: 30.h,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                        value: 0,
                        child: regularText(
                          'View Tip History',
                          fontSize: 12.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])
          ],
        ));
  }
}
