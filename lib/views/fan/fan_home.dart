import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/creator_item.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class FanHome extends StatefulWidget {
  const FanHome({Key? key}) : super(key: key);

  @override
  _FanHomeState createState() => _FanHomeState();
}

class _FanHomeState extends State<FanHome> {
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
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
      children: [
        isEmpty
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 28.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.h),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
                    ]),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/love.png',
                      height: 41.h,
                    ),
                    SizedBox(height: 8.h),
                    regularText(
                      'No Post Available',
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 14.h),
                    regularText(
                      'Support a creator to see posts from\nthe creator\n\nThere are no posts from the creators\nyou support.',
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                children: [
                  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        return creatorPost(context, index);
                      }),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.red,
                              size: 14.h,
                            ),
                            SizedBox(width: 4.h),
                            regularText(
                              'More Posts',
                              fontSize: 12.sp,
                              color: AppColors.red,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: regularText(
            'EXPLORE CREATORS',
            fontSize: 12.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.h,
              mainAxisSpacing: 16.h,
              childAspectRatio: ScreenUtil.defaultSize.width /
                  ScreenUtil.defaultSize.width *
                  .85,
            ),
            itemCount: 10,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext ctx, index) {
              return creatorItem(ctx);
            }),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColors.red,
                    size: 14.h,
                  ),
                  SizedBox(width: 4.h),
                  regularText(
                    'View all creators',
                    fontSize: 12.sp,
                    color: AppColors.red,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
