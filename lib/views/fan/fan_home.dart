import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/widgets/creator_item.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../base_view.dart';
import 'fan_layout.dart';

class FanHome extends StatefulWidget {
  const FanHome({Key? key}) : super(key: key);

  @override
  _FanHomeState createState() => _FanHomeState();
}

class _FanHomeState extends State<FanHome> {
  bool loadMorePosts = false;
  bool loadMoreCreators = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<StatViewModel>(
      onModelReady: (m) => m.getPosts(),
      builder: (_, StatViewModel postsModel, __) => BaseView<StatViewModel>(
        onModelReady: (m) => m.getExploreCreators(),
        builder: (_, StatViewModel exploreModel, __) => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 200), () {});
            exploreModel.getExploreCreators();
            return postsModel.getPosts();
          },
          color: AppColors.red,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
            children: [
              postsModel.busy
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(.1),
                            highlightColor: Colors.white60,
                            child: Container(
                              height: 150.h,
                              margin: EdgeInsets.only(top: 16.h),
                              width: ScreenUtil.defaultSize.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.7),
                                borderRadius: BorderRadius.circular(5.h),
                              ),
                            ));
                      })
                  : postsModel.allCreators == null
                      ? ErrorOccurredWidget(
                          error: postsModel.error,
                          onPressed: () {
                            postsModel.getExploreCreators();
                          },
                        )
                      : postsModel.allCreators!.isEmpty
                          ? Container(
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
                                  Image.asset(
                                    'assets/images/love.png',
                                    height: 41.h,
                                  ),
                                  SizedBox(height: 8.h),
                                  regularText(
                                    'No Post Available',
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 14.h),
                                  regularText(
                                    'Support a creator to see posts from\nthe creator\n\nThere are no posts from the creators\nyou support.',
                                    fontSize: 12.sp,
                                    color: AppColors.textGrey,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: ClampingScrollPhysics(),
                              children: [
                                ListView.builder(
                                    itemCount:
                                        postsModel.allCreators!.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (BuildContext ctx, index) {
                                      return creatorPost(context, PostModel());
                                    }),
                                SizedBox(height: 8.h),
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
                                            'More Posts',
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
                                SizedBox(height: 10.h),
                              ],
                            ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: regularText(
                  'EXPLORE CREATORS',
                  fontSize: 12.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              exploreModel.busy
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: Utils.gridDelegate(),
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(.1),
                            highlightColor: Colors.white60,
                            child: Container(
                              height: 150.h,
                              margin: EdgeInsets.only(top: 16.h),
                              width: ScreenUtil.defaultSize.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.7),
                                borderRadius: BorderRadius.circular(5.h),
                              ),
                            ));
                      })
                  : exploreModel.allCreators == null
                      ? ErrorOccurredWidget(
                          error: exploreModel.error,
                          onPressed: () {
                            exploreModel.getExploreCreators();
                          },
                        )
                      : exploreModel.allCreators!.isEmpty
                          ? AppEmptyWidget('No creators are available')
                          : ListView(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                GridView.builder(
                                    gridDelegate: Utils.gridDelegate(),
                                    itemCount: exploreModel
                                                .allCreators!.length >
                                            6
                                        ? 6
                                        : exploreModel
                                            .allCreators!.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (ctx, i) {
                                      return creatorItem(ctx,
                                          exploreModel.allCreators![i]);
                                    }),
                                SizedBox(height: 24.h),
                                if (exploreModel.allCreators!.length >
                                    6)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => fIndexNotifier.value = 1,
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
                            )
            ],
          ),
        ),
      ),
    );
  }
}
