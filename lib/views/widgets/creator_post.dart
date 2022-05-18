import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/post_details.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

Widget creatorPost(BuildContext context, PostModel post) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: InkWell(
      onTap: () {
        if (post.hidden!) {
          showDialog<AlertDialog>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) =>
                SupportDialog(creator: post.user!),
          );
          return;
        }
        if (post.user == null) {
          return showSnackBar(context, 'Info', 'No user was found');
        }
        push(context, PostDetail(post));
      },
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.grey, blurRadius: 4, spreadRadius: 2)
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
                    imageUrl: post.userImage ?? post.user?.picture ?? 'a',
                    height: 40.h,
                    width: 40.h,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Image.asset(
                      'assets/images/person.png',
                      height: 40.h,
                      width: 40.h,
                      fit: BoxFit.cover,
                    ),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) =>
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
                        '${post.userName ?? (post.user?.brandName ?? '')}',
                        fontSize: 12.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      regularText(
                        Utils.stringToDate(post.updatedAt!),
                        fontSize: 10.sp,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                )
              ],
            ),
            post.hidden == true
                ? Container(
                    height: 172.h,
                    padding: EdgeInsets.only(top: 16.h),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.h),
                          child: Image.asset(
                            'assets/images/hidden.png',
                            height: 172.h,
                            width: ScreenUtil.defaultSize.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(),
                            Image.asset(
                              'assets/images/locked.png',
                              height: 40.h,
                            ),
                            SizedBox(height: 16.h),
                            regularText(
                              'This post is for tippers',
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.h, vertical: 7.h),
                              decoration: BoxDecoration(
                                  color: AppColors.textGrey,
                                  borderRadius: BorderRadius.circular(6.h)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.favorite,
                                      color: AppColors.grey1, size: 20.h),
                                  SizedBox(width: 8.h),
                                  regularText(
                                    'Tip ${post.userName ?? (post.user?.brandName ?? '')}',
                                    fontSize: 12.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : post.image == null
                    ? SizedBox()
                    : Padding(
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
            SizedBox(height: 8.h),
            regularText(
              post.message!,
              fontSize: 12.sp,
              height: 1.8,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    ),
  );
}
