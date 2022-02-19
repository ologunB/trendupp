import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/supporter_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'creators_layout.dart';

class CreatorHome extends StatefulWidget {
  const CreatorHome({Key? key}) : super(key: key);

  @override
  _CreatorHomeState createState() => _CreatorHomeState();
}

class _CreatorHomeState extends State<CreatorHome> {
  bool isEmpty = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      isEmpty = !isEmpty;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      children: [
        SizedBox(height: 16.h),
        cardItem('wallet2', '₦22,500', 'Current Earning', AppColors.lightRed,
            AppColors.red),
        cardItem(
            'love1', '0', 'Supporters', Color(0xffFCEFE7), Color(0xffF09A4A)),
        cardItem('list1', '₦22,500', 'Current Earning', Color(0xffEDEEEE),
            Color(0xff6E757C)),
        SizedBox(height: 8.h),
        if (!isEmpty)
          Container(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            margin: EdgeInsets.only(bottom: 16.h),
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
                    child: Row(
                      children: [
                        regularText(
                          'RECENT SUPPORTERS',
                          fontSize: 14.sp,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w700,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            cIndexNotifier.value = 4;
                          },
                          child: Image.asset(
                            'assets/images/view-all.png',
                            height: 24.h,
                          ),
                        )
                      ],
                    )),
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
                      return SupporterItem();
                    }),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 28.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.h),
              boxShadow: [
                BoxShadow(color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
              ]),
          child: Column(
            children: [
              if (!isEmpty)
                Padding(
                    padding: EdgeInsets.only(left: 24.h, bottom: 20.h),
                    child: Row(
                      children: [
                        regularText(
                          'SHARE YOUR PAGE',
                          fontSize: 14.sp,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w700,
                        ),
                        Spacer(),
                      ],
                    )),
              Image.asset(
                'assets/images/love.png',
                height: 41.h,
              ),
              SizedBox(height: 12.h),
              regularText(
                isEmpty
                    ? 'You don’t have any supporters yet'
                    : 'Share your page with your audience',
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              if (isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: regularText(
                    'Share your page with your audience to\nget started.',
                    fontSize: 12.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(height: 24.h),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      border: Border.all(color: AppColors.grey, width: 1.h),
                      color: AppColors.grey),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                            height: 20.h,
                          ),
                          SizedBox(width: 12.h),
                          regularText(
                            'trendupp.com/randomname',
                            fontSize: 12.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textGrey,
                          ),
                        ],
                      ),
                      Image.asset('assets/images/tap.png', height: 24.h)
                    ],
                  )),
              SizedBox(height: 24.h),
              regularText(
                'Share on',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tw.png', width: 28.h),
                  SizedBox(width: 30.h),
                  Image.asset('assets/images/fb.png', width: 28.h),
                  SizedBox(width: 30.h),
                  Image.asset('assets/images/ws.png', width: 28.h),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
        SizedBox(height: 16.h),
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
                  'QUICK TIPS',
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              ListView.separated(
                  separatorBuilder: (_, __) {
                    return Divider(
                        color: AppColors.textGrey.withOpacity(.4), height: 2.h);
                  },
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 24.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/tip$index.png',
                            height: 30.h,
                          ),
                          SizedBox(width: 16.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              regularText('TIP' + (index + 1).toString(),
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700),
                              regularText(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu',
                                fontSize: 12.sp,
                                height: 1.7,
                                color: AppColors.textGrey,
                              ),
                            ],
                          )),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
