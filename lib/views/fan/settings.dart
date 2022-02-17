import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'user_bio.dart';
import 'change_password.dart';

class FanSettings extends StatefulWidget {
  const FanSettings({Key? key}) : super(key: key);

  @override
  _FanSettingsState createState() => _FanSettingsState();
}

class _FanSettingsState extends State<FanSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
      children: [
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
                  'SETTINGS',
                  fontSize: 12.sp,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          push(context, FanBio());
                        } else {
                          push(context, ChangePassword());
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 24.h),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/info$index.png',
                              height: 40.h,
                            ),
                            SizedBox(width: 16.h),
                            Expanded(
                              child: regularText(list[index],
                                  fontSize: 12.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.textGrey,
                              size: 16.h,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  List<String> list = ['User Details', 'Change password'];
}
