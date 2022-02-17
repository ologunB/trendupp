import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/creator_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class SupportedCreators extends StatefulWidget {
  const SupportedCreators({Key? key}) : super(key: key);

  @override
  _SupportedCreatorsState createState() => _SupportedCreatorsState();
}

class _SupportedCreatorsState extends State<SupportedCreators> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 13.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: regularText(
            'SUPPORTED CREATORS',
            fontSize: 12.sp,
            color: AppColors.lightBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: CustomTextField(
            hintText: 'Search Here.',
            controller: search,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/search.png', height: 14.h),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 8.h),
            shrinkWrap: true,
            children: [
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
          ),
        )
      ],
    );
  }
}
