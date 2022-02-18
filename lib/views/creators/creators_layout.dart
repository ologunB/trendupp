import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/choose_signup.dart';
import 'package:mms_app/views/creators/add_post.dart';
import 'package:mms_app/views/creators/posts_history.dart';
import 'package:mms_app/views/creators/settings.dart';
import 'package:mms_app/views/creators/supporters_history.dart';
import 'package:mms_app/views/creators/wallet_history.dart';
import 'package:mms_app/views/fan/creator_details.dart';
import 'package:mms_app/views/fan/fan_home.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'creator_home.dart';

class CreatorLayout extends StatefulWidget {
  @override
  _CreatorLayoutState createState() => _CreatorLayoutState();
}

class _CreatorLayoutState extends State<CreatorLayout> {
  int currentIndex = 0;

  List<Widget> views() => [
        CreatorHome(),
        FanHome(),
        CreatorDetails(hasHeader: false),
        PostsHistory(),
        SupportersHistory(),
        WalletHistory(),
        CreatorSettings(),
      ];

  GlobalKey<ScaffoldState> mainLayoutScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(bContext) {
    return Scaffold(
      key: mainLayoutScaffoldKey,
      appBar: AppBar(
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
              Image.asset('assets/images/logo.png', height: 32.h),
              Spacer(),
              InkWell(
                  onTap: () {
                    mainLayoutScaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset('assets/images/menu.png', height: 20.h)),
            ],
          ),
        ),
      ),
      body: views()[currentIndex],
      drawer: drawerWidget(bContext),
    );
  }

  Widget drawerWidget(BuildContext bContext) {
    return SizedBox(
      width: ScreenUtil.defaultSize.width * .75,
      child: Drawer(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 16.h),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/person.png', width: 60.h),
                  ],
                ),
                SizedBox(height: 10.h),
                regularText(
                  'Twyse Ereme',
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 16.h),
                addPost(),
                SizedBox(height: 32.h),
                item('Dashboard', 0),
                item('Creators I support', 1),
                item('My Page', 2),
                item('My Post', 3),
                item('Supporters', 4),
                item('Wallet', 5),
                item('Settings', 6),
                item('Logout', 7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(String a, int i) {
    String img = a == 'Creators I support' ? 'Home' : a;
    return InkWell(
      onTap: () {
        if (i == 7) {
          showDialog<AlertDialog>(
            context: context,
            builder: (BuildContext bContext) => Container(
              color: AppColors.darkBlue.withOpacity(.1),
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    regularText(
                      'Logout',
                      fontSize: 15.sp,
                      textAlign: TextAlign.center,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: regularText(
                        'Are you sure you want to logout from your account?',
                        fontSize: 13.sp,
                        textAlign: TextAlign.center,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(bContext);
                            },
                            child: regularText(
                              'Cancel',
                              fontSize: 13.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(bContext);
                              pushAndRemoveUntil(context, ChooseSignup());
                            },
                            child: regularText(
                              'Confirm',
                              fontSize: 13.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h)),
              ),
            ),
          );
          return;
        }
        currentIndex = i;
        setState(() {});
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 30.h,
              child: Image.asset(
                'assets/images/$img.png',
                height: 25.h,
                color: currentIndex == i ? AppColors.red : AppColors.textGrey,
              ),
            ),
            SizedBox(width: 12.h),
            regularText(
              a,
              fontSize: 14.sp,
              color: currentIndex == i ? AppColors.red : AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  bool postIsOpen = false;

  Widget addPost() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 4000),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                postIsOpen = !postIsOpen;
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColors.white,
                    size: 16.h,
                  ),
                  SizedBox(width: 10.h),
                  regularText(
                    'Post',
                    fontSize: 14.sp,
                    textAlign: TextAlign.center,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(width: 12.h),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.white,
                    size: 20.h,
                  ),
                ],
              ),
            ),
            if (postIsOpen)
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        postIsOpen = !postIsOpen;
                        setState(() {});
                        push(context, AddPost(type: 0));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/people.png',
                            height: 20.h,
                          ),
                          SizedBox(width: 16.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regularText(
                                  'Public',
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                regularText(
                                  'Post to general viewers of Trendupp',
                                  fontSize: 8.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                        postIsOpen = !postIsOpen;
                        setState(() {});
                        push(context, AddPost(type: 1));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/Supporters.png',
                            height: 20.h,
                            color: AppColors.grey1,
                          ),
                          SizedBox(width: 16.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regularText(
                                  'Your Supporters',
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                regularText(
                                  'Post to general viewers of your page',
                                  fontSize: 8.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ));
  }
}
