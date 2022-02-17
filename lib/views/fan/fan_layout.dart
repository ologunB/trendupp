import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/login.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'explore_creators.dart';
import 'fan_home.dart';
import 'settings.dart';
import 'support_history.dart';
import 'supported_creators.dart';

class FanLayout extends StatefulWidget {
  @override
  _FanLayoutState createState() => _FanLayoutState();
}

class _FanLayoutState extends State<FanLayout> {
  int currentIndex = 0;

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
                              pushAndRemoveUntil(context, LoginView());
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
                'assets/images/$a.png',
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
}
