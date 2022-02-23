import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/cantsupport_dialog.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(this.post);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Image.asset('assets/images/logo2.png', height: 32.h),
                Spacer(),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 24.h),
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
                          '${(post.userName ?? post.user!.firstName)!.toUpperCase()}’S PAGE',
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
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.h),
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.h),
                        child: CachedNetworkImage(
                          imageUrl: post.userImage ?? post.user!.picture ?? "c",
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Image.asset(
                            'assets/images/person.png',
                            height: 40.h,
                            width: 40.h,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Image.asset(
                            'assets/images/person.png',
                            height: 40.h,
                            width: 40.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 13.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                              '${post.userName ?? ((post.user!.firstName ?? '') + ' ' + (post.user!.lastName ?? ''))}',
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            regularText(
                              Utils.stringToDate(post.createdAt!),
                              fontSize: 10.sp,
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (post.image != null)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.h),
                        child: CachedNetworkImage(
                          imageUrl: post.image!,
                          height: 172.h,
                          width: ScreenUtil.defaultSize.width,
                          fit: BoxFit.fitWidth,
                          placeholder: (_, __) => Image.asset(
                            'assets/images/placeholder.png',
                            height: 172.h,
                            width: ScreenUtil.defaultSize.width,
                            fit: BoxFit.fitWidth,
                          ),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Image.asset(
                            'assets/images/placeholder.png',
                            height: 172.h,
                            width: ScreenUtil.defaultSize.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 16.h),
                  regularText(
                    post.title!,
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 12.h),
                  regularText(
                    post.message!,
                    fontSize: 12.sp,
                    height: 1.8,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog<AlertDialog>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) =>
                                AppCache.getUser()!.userType == 'fan'
                                    ? SupportDialog(creator: post.user!)
                                    : CantSupportDialog(
                                        user:
                                            UserData(firstName: post.userName)),
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
                            children: [
                              Icon(Icons.favorite,
                                  color: AppColors.lightRed, size: 20.h),
                              SizedBox(width: 8.h),
                              regularText(
                                'Support ${post.userName ?? post.user!.firstName}',
                                fontSize: 12.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ));
  }
}
