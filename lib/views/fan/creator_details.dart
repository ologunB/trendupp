import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class CreatorDetails extends StatefulWidget {
  const CreatorDetails({Key? key, this.hasHeader =true }) : super(key: key);

 final bool hasHeader ;
  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}

class _CreatorDetailsState extends State<CreatorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:!widget.hasHeader ? null: AppBar(
        elevation: 0,
        leadingWidth: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leading: SizedBox(),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/logo2.png', height: 32.h),
              Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.h, vertical: 16.h),
        color: AppColors.lightRed,
        child: InkWell(
          onTap: () {
            showDialog<AlertDialog>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) => SupportDialog(),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 7.h),
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(6.h)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: AppColors.lightRed, size: 20.h),
                SizedBox(width: 8.h),
                regularText(
                  'Support Twyse',
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
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 55.h),
          Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: -50.h,
                      left: 0.h,
                      right: 0.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.h),
                            child: Image.asset(
                              'assets/images/placeholder.png',
                              height: 100.h,
                              width: 100.h,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 42.h),
                        regularText(
                          'Twyse Ereme',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.h),
                          child: regularText(
                            'Travel & Lifestyle Youtuber Living in Lagos, Nigeria.',
                            fontSize: 14.sp,
                            color: AppColors.textGrey,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        InkWell(
                          onTap: () {
                            showDialog<AlertDialog>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) =>
                                  SupportDialog(),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.h, vertical: 7.h),
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(6.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.favorite,
                                    color: AppColors.lightRed, size: 20.h),
                                SizedBox(width: 8.h),
                                regularText(
                                  'Support Twyse',
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Divider(
                            height: 0, thickness: 1, color: AppColors.grey2),
                        SizedBox(height: 13.h),
                        regularText(
                          'Kia ora and hello from Aotearoa, the land of the long white cloud. Join my Virtual Walking Tours around New Zealand. Enjoy beautiful nature, local lifestyle, food and fun. Join Lunch with Louise for cooking and food, coffee and cafes. Let’s Go to the real Middle Earth and walk on Rainbows and Fossil Forests. Join me daily on Happs.tv,IG,Youtube & Twitter.I love my coffee. Your coffees keep me inspired and motivated so I can share lots more with you. Thank you.',
                          fontSize: 12.sp,
                          height: 1.6,
                          color: AppColors.textGrey,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<String>.generate(
                                  5, (index) => 'sh' + index.toString())
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(4.h),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/images/$e.png',
                                        width: 38.h,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext ctx, index) {
                return creatorPost(context, index);
              }),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
