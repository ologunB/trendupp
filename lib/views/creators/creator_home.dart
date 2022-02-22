import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/stat_api.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/supporter_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mms_app/views/widgets/utils.dart';
import '../base_view.dart';
import 'creators_layout.dart';

class CreatorHome extends StatefulWidget {
  const CreatorHome({Key? key}) : super(key: key);

  @override
  _CreatorHomeState createState() => _CreatorHomeState();
}

class _CreatorHomeState extends State<CreatorHome> {
  @override
  Widget build(BuildContext context) {
    print(AppCache.getToken());
    return BaseView<StatViewModel>(
        onModelReady: (m) => m.getCreatorStat(),
        builder: (_, StatViewModel statModel, __) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              children: [
                SizedBox(height: 16.h),
                statModel.busy
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(.1),
                              highlightColor: Colors.white60,
                              child: Container(
                                height: 70.h,
                                margin: EdgeInsets.only(bottom: 16.h),
                                width: ScreenUtil.defaultSize.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                              ));
                        })
                    : Column(
                        children: [
                          cardItem(
                              'wallet2',
                              '₦ ${statModel.creatorStat?.amount?.toString().toAmount() ?? 0}',
                              'Current Earning',
                              AppColors.lightRed,
                              AppColors.red),
                          cardItem(
                              'love1',
                              '${statModel.creatorStat?.supporters?.length ?? 0}',
                              'Supporters',
                              Color(0xffFCEFE7),
                              Color(0xffF09A4A)),
                          cardItem(
                              'list1',
                              '${statModel.creatorStat?.posts ?? 0}',
                              'Posts',
                              Color(0xffEDEEEE),
                              Color(0xff6E757C)),
                        ],
                      ),
                SizedBox(height: 8.h),
                if ((statModel.creatorStat?.supporters?.isNotEmpty ?? false) &&
                    !statModel.busy)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 28.h),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.h),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 6,
                              spreadRadius: 2)
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
                            itemCount:
                                statModel.creatorStat!.supporters!.length > 5
                                    ? 5
                                    : statModel.creatorStat!.supporters!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (BuildContext ctx, i) {
                              Supporters support =
                                  statModel.creatorStat!.supporters![i];
                              return SupporterItem(support);
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
                        BoxShadow(
                            color: AppColors.grey,
                            blurRadius: 6,
                            spreadRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      if (statModel.creatorStat?.supporters?.isNotEmpty ??
                          false)
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
                        statModel.creatorStat?.supporters?.isEmpty ?? true
                            ? 'You don’t have any supporters yet'
                            : 'Share your page with your audience',
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      if (statModel.creatorStat?.supporters?.isEmpty ?? true)
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
                              border:
                                  Border.all(color: AppColors.grey, width: 1.h),
                              color: AppColors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.h, vertical: 10.h),
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
                                    'trendupp.com/${AppCache.getUser()!.userName}',
                                    fontSize: 12.sp,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textGrey,
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            'trendupp.com/${AppCache.getUser()!.userName}'));
                                    showSnackBar(
                                      context,
                                      'Copied',
                                      'Link has been copied to clipboard',
                                    );
                                  },
                                  child: Image.asset('assets/images/tap.png',
                                      height: 24.h))
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
                          InkWell(
                            onTap: () {},
                            child: Image.asset('assets/images/tw.png',
                                width: 28.h),
                          ),
                          SizedBox(width: 30.h),
                          InkWell(
                            onTap: () {},
                            child: Image.asset('assets/images/fb.png',
                                width: 28.h),
                          ),
                          SizedBox(width: 30.h),
                          InkWell(
                            onTap: () {},
                            child: Image.asset('assets/images/ws.png',
                                width: 28.h),
                          ),
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
                        BoxShadow(
                            color: AppColors.grey,
                            blurRadius: 6,
                            spreadRadius: 2)
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
                                color: AppColors.textGrey.withOpacity(.4),
                                height: 2.h);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      regularText(
                                          'TIP' + (index + 1).toString(),
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
            ));
  }
}
