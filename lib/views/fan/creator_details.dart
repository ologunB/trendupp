import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/cantsupport_dialog.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:social_share/social_share.dart';
import 'dart:io';

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
  Widget build(BuildContext context) {
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
                builder: (BuildContext context) => !widget.isFan
                    ? SupportDialog(creator: user)
                    : CantSupportDialog(user: user),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 7.h),
              decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(6.h)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: AppColors.lightRed, size: 20.h),
                  SizedBox(width: 8.h),
                  regularText(
                    'Support ${user.firstName}',
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
                              imageUrl: user.picture!,
                              height: 100.h,
                              width: 100.h,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Image.asset(
                                'assets/images/person.png',
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (BuildContext context, String url,
                                      dynamic error) =>
                                  Image.asset(
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
                          '${user.firstName} ${user.lastName}',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.h),
                        child: regularText(
                          '${user.about}',
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
                              borderRadius: BorderRadius.circular(6.h)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite,
                                  color: AppColors.lightRed, size: 20.h),
                              SizedBox(width: 8.h),
                              regularText(
                                'Support ${user.firstName}',
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
                          '${user.creating}',
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
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext ctx, index) {
                return creatorPost(context, index);
              }),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  File? imageFile;

  Widget linksWidget() {
    String link = 'https://trendupp.com/' + user.userName!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<String>.generate(5, (index) => 'sh' + index.toString())
          .map((e) => Padding(
                padding: EdgeInsets.all(4.h),
                child: InkWell(
                  onTap: () async {
                    try {
                      String path =
                          '${(await getTemporaryDirectory()).path}/bg.png';
                      await getImageFileFromAssets(path);

                      print(path);
                      if (e == 'sh0') {
                        SocialShare.shareTwitter("Support me on Trendupp ",
                            hashtags: ["trendupp", "support"], url: link);
                      } else if (e == 'sh1') {
                        Share.share("Support me on Trendupp on $link",
                            subject: 'Share Support');
                      } else if (e == 'sh2') {
                        Share.share("Support me on Trendupp on $link",
                            subject: 'Share Support');
                      } else if (e == 'sh3') {
                        SocialShare.shareFacebookStory(
                            path, "#ffffff", "#000000", link,
                            appId: '481033083584762');
                      } else if (e == 'sh4') {
                        Share.share("Support me on Trendupp on $link",
                            subject: 'Share Support');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Image.asset(
                    'assets/images/$e.png',
                    width: 38.h,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Future<File> getImageFileFromAssets(String _path) async {
    final byteData = await rootBundle.load('assets/images/bg.png');
    final File file = File(_path);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
}
