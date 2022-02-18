import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class SupportHistory extends StatefulWidget {
  const SupportHistory({Key? key, this.hasHeader = false}) : super(key: key);
  final bool hasHeader;

  @override
  _SupportHistoryState createState() => _SupportHistoryState();
}

class _SupportHistoryState extends State<SupportHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.hasHeader
          ? null
          : AppBar(
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.h),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
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
                ListView.separated(
                    separatorBuilder: (_, __) {
                      return Divider(
                          color: AppColors.textGrey.withOpacity(.4),
                          height: 2.h);
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 24.h),
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
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: regularText(
                                'Jun 10, 2021 at 02:12 PM',
                                fontSize: 12.sp,
                                color: AppColors.textGrey,
                              ),
                            ),
                            regularText(
                              '₦ 5,000',
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
    );
  }
}
