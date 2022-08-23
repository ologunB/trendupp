import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/creators/add_post.dart';
import 'package:mms_app/views/creators/creator_bio.dart';
import 'package:mms_app/views/creators/posts_history.dart';
import 'package:mms_app/views/creators/settings.dart';
import 'package:mms_app/views/creators/supporters_history.dart';
import 'package:mms_app/views/creators/wallet_history.dart';
import 'package:mms_app/views/fan/creator_details.dart';
import 'package:mms_app/views/fan/fan_home.dart';
import 'package:mms_app/views/widgets/logout_dialog.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'creator_home.dart';
import 'dart:math';

class CreatorLayout extends StatefulWidget {
  @override
  _CreatorLayoutState createState() => _CreatorLayoutState();
}

ValueNotifier<int> cIndexNotifier = ValueNotifier(0);

class _CreatorLayoutState extends State<CreatorLayout> {
  List<Widget> views() => [
        CreatorHome(),
        FanHome(),
        CreatorDetails(isFan: false, userData: AppCache.getUser()),
        PostsHistory(),
        SupportersHistory(),
        WalletHistory(),
        CreatorSettings(),
      ];

  GlobalKey<ScaffoldState> mainLayoutScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(bContext) {
    return ValueListenableBuilder<int>(
        valueListenable: cIndexNotifier,
        builder: (_, a, __) {
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
                child: Stack(
                  children: [
                    Center(
                        child: Image.asset('assets/images/logo2.png',
                            height: 32.h)),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        mainLayoutScaffoldKey.currentState!.openDrawer();
                      },
                      child: Transform.rotate(
                        angle: pi,
                        child:
                            Image.asset('assets/images/menu.png', height: 20.h),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: views()[a],
            drawer: drawerWidget(bContext),
          );
        });
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
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      CupertinoPageRoute<dynamic>(
                        builder: (BuildContext context) => CreatorBio(),
                      ),
                    );
                    setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.h),
                            child: CachedNetworkImage(
                              imageUrl: AppCache.getUser()?.picture ?? 'a',
                              height: 60.h,
                              width: 60.h,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Image.asset(
                                'assets/images/person.png',
                                height: 60.h,
                                width: 60.h,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (BuildContext context, String url,
                                      dynamic error) =>
                                  Image.asset(
                                'assets/images/person.png',
                                height: 60.h,
                                width: 60.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      regularText(
                        '${AppCache.getUser()?.brandName}',
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                addPost(),
                SizedBox(height: 32.h),
                item('Dashboard', 0),
                //   item('Creators I support', 1),
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
              builder: (BuildContext bContext) => LogoutDialog());
          return;
        }
        cIndexNotifier.value = i;
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
                color: cIndexNotifier.value == i
                    ? AppColors.red
                    : AppColors.textGrey,
              ),
            ),
            SizedBox(width: 12.h),
            regularText(
              a,
              fontSize: 14.sp,
              color: cIndexNotifier.value == i
                  ? AppColors.red
                  : AppColors.textGrey,
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
                        push(context,
                            AddPost(model: PostModel(postType: 'public')));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/people.png',
                            height: 20.h,
                            color: Color(0xffd38ca5),
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
                                  fontSize: 10.sp,
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
                        push(context,
                            AddPost(model: PostModel(postType: 'supporters')));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/Supporters.png',
                            height: 20.h,
                            color: Color(0xffD38CA5),
                          ),
                          SizedBox(width: 16.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                regularText(
                                  'Tippers',
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                regularText(
                                  'Post to your tippers of your page',
                                  fontSize: 10.sp,
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
