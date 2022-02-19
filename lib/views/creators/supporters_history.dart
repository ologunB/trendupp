import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/supporter_item.dart';
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
                    return SupporterItem();
                  }),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
