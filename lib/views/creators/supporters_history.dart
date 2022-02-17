import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/support_history.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class SupportersHistory extends StatefulWidget {
  const SupportersHistory({Key? key}) : super(key: key);

  @override
  _SupportersHistoryState createState() => _SupportersHistoryState();
}

class _SupportersHistoryState extends State<SupportersHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
      children: [
        cardItem(
            'love1', '0', 'Supporters', Color(0xffFCEFE7), Color(0xffF09A4A)),
        Container(
          padding: EdgeInsets.symmetric(vertical: 28.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.h),
              boxShadow: [
                BoxShadow(color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
              ]),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: regularText(
                  'SUPPORTERS',
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListView.separated(
                  separatorBuilder: (_, __) {
                    return Divider(
                        color: AppColors.textGrey.withOpacity(.4), height: 2.h);
                  },
                  itemCount: 3,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 24.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  regularText(
                                    'Tomiwa Odufuwa',
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.h),
                                    child: regularText(
                                      'Jun 10, 2021 at 02:12 PM',
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.h),
                                    child: regularText(
                                      'Mogbosultimate@gmail.com',
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  regularText(
                                    '₦10,000',
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
                                    push(context, SupportHistory(hasHeader: true));
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/more.png',
                                  height: 30.h,
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<int>>[
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: regularText(
                                          'View Support History',
                                          fontSize: 12.sp,
                                          color: AppColors.textGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ])
                          ],
                        ));
                  }),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
