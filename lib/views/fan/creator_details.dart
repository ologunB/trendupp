import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/post_vm.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/cantsupport_dialog.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../base_view.dart';

class CreatorDetails extends StatefulWidget {
  const CreatorDetails({Key? key, this.isFan = true, this.userData})
      : super(key: key);

  final bool isFan;
  final UserData? userData;

  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}

class _CreatorDetailsState extends State<CreatorDetails> {
  UserData user = UserData();

  @override
  void initState() {
    user = widget.userData!;
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: !widget.isFan
          ? null
          : AppBar(
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
                    Image.asset('assets/images/logo2.png', height: 32.h),
                    Spacer(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.h, vertical: 16.h),
        color: AppColors.lightRed,
        child: SafeArea(
          child: InkWell(
            onTap: () {
              showDialog<AlertDialog>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => widget.isFan
                    ? SupportDialog(creator: user)
                    : CantSupportDialog(user: user),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 7.h),
              decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(6.h)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: AppColors.lightRed, size: 20.h),
                  SizedBox(width: 8.h),
                  regularText(
                    'Tip ${user.brandName ?? user.firstName}',
                    fontSize: 12.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        physics: ClampingScrollPhysics(),
        children: [
          if (widget.isFan)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.lightBlack,
                          size: 16.h,
                        ),
                        SizedBox(width: 6.h),
                        regularText(
                          'BACK',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 55.h),
          Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: -50.h,
                      left: 0.h,
                      right: 0.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.h),
                            child: CachedNetworkImage(
                              imageUrl: user.picture ?? 'a',
                              height: 100.h,
                              width: 100.h,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Image.asset(
                                'assets/images/person.png',
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (_, __, ___) => Image.asset(
                                'assets/images/person.png',
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 58.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: regularText(
                          '${user.brandName ?? user.firstName}',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      BaseView<PostViewModel>(
                          onModelReady: (m) =>
                              m.supportersByUsername(widget.userData!, context),
                          builder: (_, PostViewModel sModel, __) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.h),
                                child: regularText(
                                  '${sModel.supportersNumber} ${sModel.supportersNumber > 1 ? 'Tippers' : "Tipper"}',
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.h),
                        child: regularText(
                          '${user.creating}',
                          fontSize: 14.sp,
                          color: AppColors.textGrey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      InkWell(
                        onTap: () {
                          showDialog<AlertDialog>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) => widget.isFan
                                ? SupportDialog(creator: user)
                                : CantSupportDialog(user: user),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.h, vertical: 7.h),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(6.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite,
                                  color: AppColors.lightRed, size: 20.h),
                              SizedBox(width: 8.h),
                              regularText(
                                'Tip ${user.brandName ?? user.firstName}',
                                fontSize: 12.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Divider(height: 0, thickness: 1, color: AppColors.grey2),
                      SizedBox(height: 13.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: regularText(
                          '${user.about}',
                          fontSize: 12.sp,
                          height: 1.6,
                          color: AppColors.textGrey,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      linksWidget(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ],
              )),
          BaseView<PostViewModel>(
              onModelReady: (m) => widget.isFan
                  ? m.postByUsername(widget.userData!, context)
                  : m.getPosts(context),
              builder: (_, PostViewModel model, __) => model.busy &&
                      model.creatorsPost == null
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
                              height: 120.h,
                              margin: EdgeInsets.only(top: 16.h),
                              width: ScreenUtil.defaultSize.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.7),
                                borderRadius: BorderRadius.circular(5.h),
                              ),
                            ));
                      })
                  : model.creatorsPost == null
                      ? ErrorOccurredWidget(
                          error: model.error!,
                          onPressed: () {
                            widget.isFan
                                ? model.postByUsername(
                                    widget.userData!, context)
                                : model.getPosts(context);
                          },
                        )
                      : model.creatorsPost!.isEmpty
                          ? AppEmptyWidget(AppCache.getUser()!.userType == 'fan'
                              ? '${user.brandName ?? user.firstName} has no post yet'
                              : 'You have not made any post')
                          : ListView.builder(
                              itemCount: model.creatorsPost!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (BuildContext ctx, i) {
                                PostModel post = model.creatorsPost![i];
                                post.user = widget.userData;
                                return creatorPost(context, post);
                              })),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  File? imageFile;

  Widget linksWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.userData!.twitterLink?.isEmpty == false)
          socialItem(0, 'https://twitter.com/' + widget.userData!.twitterLink!),
        if (widget.userData!.instagramLink?.isEmpty == false)
          socialItem(
              1, 'http://www.instagram.com/' + widget.userData!.instagramLink!),
        if (widget.userData!.youtubeLink?.isEmpty == false)
          socialItem(
              2, 'https://www.youtube.com/' + widget.userData!.youtubeLink!),
        if (widget.userData!.facebookLink?.isEmpty == false)
          socialItem(
              3, 'https://web.facebook.com/' + widget.userData!.facebookLink!),
        if (widget.userData!.websiteUrl?.isEmpty == false)
          socialItem(4, 'https://' + widget.userData!.websiteUrl!),
      ],
    );
  }

  Widget socialItem(int e, String url) {
    return Padding(
      padding: EdgeInsets.all(4.h),
      child: InkWell(
        onTap: () async {
          await launchUrl(Uri.parse(url));
        },
        child: Image.asset(
          'assets/images/sh$e.png',
          width: 38.h,
        ),
      ),
    );
  }
}
