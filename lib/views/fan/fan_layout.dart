import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/fan/user_bio.dart';
import 'package:mms_app/views/widgets/logout_dialog.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'explore_creators.dart';
import 'fan_home.dart';
import 'settings.dart';
import 'support_history.dart';
import 'supported_creators.dart';
import 'dart:math';

class FanLayout extends StatefulWidget {
  @override
  _FanLayoutState createState() => _FanLayoutState();
}

ValueNotifier<int> fIndexNotifier = ValueNotifier(0);

class _FanLayoutState extends State<FanLayout> {
  List<Widget> views() => [
        FanHome(),
        ExploreCreators(),
        SupportedCreators(),
        SupportHistory(),
        FanSettings(),
      ];

  GlobalKey<ScaffoldState> mainLayoutScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(bContext) {
    return ValueListenableBuilder<int>(
        valueListenable: fIndexNotifier,
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
                        child: Image.asset('assets/images/logo.png',
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
                        builder: (BuildContext context) => FanBio(),
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
                              errorWidget: (_, __, ___) => Image.asset(
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
                        '${AppCache.getUser()?.firstName} ${AppCache.getUser()?.lastName}',
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                item('Home', 0),
                item('Explore Creators', 1),
                item('Supported Creators', 2),
                item('Support History', 3),
                item('Settings', 4),
                item('Logout', 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(String a, int i) {
    return InkWell(
      onTap: () {
        if (i == 5) {
          showDialog<AlertDialog>(
              context: context,
              builder: (BuildContext bContext) => LogoutDialog());
          return;
        }
        fIndexNotifier.value = i;
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
                'assets/images/$a.png',
                height: 25.h,
                color: fIndexNotifier.value == i
                    ? AppColors.red
                    : AppColors.textGrey,
              ),
            ),
            SizedBox(width: 12.h),
            regularText(
              a,
              fontSize: 14.sp,
              color: fIndexNotifier.value == i
                  ? AppColors.red
                  : AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
