import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/supporter_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:social_share/social_share.dart';
import '../base_view.dart';
import 'creators_layout.dart';

class CreatorHome extends StatefulWidget {
  const CreatorHome({Key? key}) : super(key: key);

  @override
  _CreatorHomeState createState() => _CreatorHomeState();
}

class _CreatorHomeState extends State<CreatorHome> {
  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext _) {
    return BaseView<StatViewModel>(
        onModelReady: (m) => m.getCreatorStat(context),
        builder: (_, StatViewModel statModel, __) => Scaffold(
              floatingActionButton: !_showBackToTopButton
                  ? null
                  : FloatingActionButton(
                      backgroundColor: AppColors.red,
                      onPressed: _scrollToTop,
                      child: Icon(Icons.keyboard_arrow_up),
                      tooltip: 'Scroll to up',
                    ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 200), () {});
                  return statModel.getCreatorStat(context);
                },
                color: AppColors.red,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  children: [
                    SizedBox(height: 16.h),
                    statModel.busy && statModel.creatorStat == null
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
                                  '${statModel.creatorStat?.supportersNumber?.toString() ?? 0}',
                                  'Tippers',
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
                    if ((statModel.creatorStat?.supporters?.isNotEmpty ??
                            false) &&
                        statModel.creatorStat?.supporters != null)
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
                                      'RECENT TIPPERS',
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
                                itemCount: statModel
                                            .creatorStat!.supporters!.length >
                                        5
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
                                padding:
                                    EdgeInsets.only(left: 24.h, bottom: 20.h),
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
                          if (statModel.creatorStat?.supporters?.isEmpty ??
                              true)
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
                                  border: Border.all(
                                      color: AppColors.grey, width: 1.h),
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
                                        'trendupp.com/${AppCache.getUser()?.userName}',
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
                                                'trendupp.com/${AppCache.getUser()?.userName}'));
                                        showSnackBar(
                                          context,
                                          'Copied',
                                          'Link has been copied to clipboard',
                                        );
                                      },
                                      child: Image.asset(
                                          'assets/images/tap.png',
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
                          linksWidget(),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ));
  }

  Widget tipsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
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
                    color: AppColors.textGrey.withOpacity(.4), height: 2.h);
              },
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.h),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          regularText('SUPPORT' + (index + 1).toString(),
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
    );
  }

  Widget linksWidget() {
    String link =
        'https://trendupp.com/' + (AppCache.getUser()?.userName ?? '');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            try {
              await SocialShare.shareTwitter(
                "Support me on Trendupp ",
                hashtags: ["trendupp", "support"],
                url: link,
              );
            } catch (e) {
              print(e);
            }
          },
          child: Image.asset('assets/images/tw.png', width: 28.h),
        ),
        SizedBox(width: 30.h),
        InkWell(
          onTap: () {
            SocialShare.shareOptions("Support me on Trendupp via $link");
          },
          child: Image.asset('assets/images/fb.png', width: 28.h),
        ),
        SizedBox(width: 30.h),
        InkWell(
          onTap: () {
            SocialShare.shareWhatsapp("Support me on Trendupp via $link");
          },
          child: Image.asset('assets/images/ws.png', width: 28.h),
        ),
      ],
    );
  }
}
