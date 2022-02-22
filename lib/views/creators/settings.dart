import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/change_password.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'creator_bio.dart';
import 'update_bank.dart';
import 'update_link.dart';

class CreatorSettings extends StatefulWidget {
  const CreatorSettings({Key? key}) : super(key: key);

  @override
  _CreatorSettingsState createState() => _CreatorSettingsState();
}

class _CreatorSettingsState extends State<CreatorSettings> {
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
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () async {
                        if (index == 0) {
                          await Navigator.push(
                            context,
                            CupertinoPageRoute<dynamic>(
                              builder: (BuildContext context) => CreatorBio(),
                            ),
                          );
                          setState(() {});
                        } else if (index == 1) {
                          push(context, ChangePassword());
                        } else if (index == 2) {
                          push(context, UpdateLink());
                        } else if (index == 3) {
                          push(context, UpdateBank());
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

  List<String> list = [
    'User Details',
    'Change password',
    'Change your link',
    'Update Bank Account'
  ];
}
