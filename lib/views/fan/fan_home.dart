import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/widgets/creator_post.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../base_view.dart';
import 'creator_details.dart';
import 'fan_layout.dart';

class FanHome extends StatefulWidget {
  const FanHome({Key? key}) : super(key: key);

  @override
  _FanHomeState createState() => _FanHomeState();
}

class _FanHomeState extends State<FanHome> {
  bool loadMorePosts = false;
  int postsToLoad = 6;

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
      onModelReady: (m) =>
          m.getFanPosts(AppCache.getUser()?.email ?? '', context),
      builder: (_, StatViewModel postsModel, __) => BaseView<StatViewModel>(
          onModelReady: (m) => m.getExploreCreators(context),
          builder: (_, StatViewModel exploreModel, __) => Scaffold(
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
                    exploreModel.getExploreCreators(context);
                    return postsModel.getFanPosts(
                        AppCache.getUser()!.email!, context);
                  },
                  color: AppColors.red,
                  child: ListView(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
                    children: [
                      postsModel.busy && postsModel.allPosts == null
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
                                        borderRadius:
                                            BorderRadius.circular(5.h),
                                      ),
                                    ));
                              })
                          : postsModel.allPosts == null
                              ? ErrorOccurredWidget(
                                  error: postsModel.error,
                                  onPressed: () {
                                    postsModel.getFanPosts(
                                        AppCache.getUser()!.email!, context);
                                  },
                                )
                              : postsModel.allPosts!.isEmpty
                                  ? Image.asset(
                                      'assets/images/no-content.png',
                                      height:
                                          MediaQuery.of(context).size.width -
                                              48.h,
                                    )
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: ClampingScrollPhysics(),
                                      children: [
                                        ListView.builder(
                                            itemCount: loadMorePosts
                                                ? postsModel.allPosts!.length
                                                : (postsModel.allPosts!.length >
                                                        postsToLoad
                                                    ? postsToLoad
                                                    : postsModel
                                                        .allPosts!.length),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: ClampingScrollPhysics(),
                                            itemBuilder: (ctx, i) {
                                              return creatorPost(context,
                                                  postsModel.allPosts![i]);
                                            }),
                                        if (postsModel.allPosts!.length >
                                            postsToLoad)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    loadMorePosts =
                                                        !loadMorePosts;
                                                    setState(() {});
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: AppColors.red,
                                                        size: 14.h,
                                                      ),
                                                      SizedBox(width: 4.h),
                                                      regularText(
                                                        loadMorePosts
                                                            ? 'Less Posts'
                                                            : 'More Posts',
                                                        fontSize: 12.sp,
                                                        color: AppColors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                      exploreModel.busy && exploreModel.allCreators == null
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
                                        borderRadius:
                                            BorderRadius.circular(5.h),
                                      ),
                                    ));
                              })
                          : exploreModel.allCreators == null
                              ? ErrorOccurredWidget(
                                  error: exploreModel.error,
                                  onPressed: () {
                                    exploreModel.getExploreCreators(context);
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
                                              UserData data =
                                                  exploreModel.allCreators![i];
                                              return InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    CupertinoPageRoute<dynamic>(
                                                        builder: (BuildContext
                                                                context) =>
                                                            CreatorDetails(
                                                                userData:
                                                                    data)),
                                                  );
                                                  postsModel.getFanPosts(
                                                      AppCache.getUser()!
                                                          .email!,
                                                      context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16.h,
                                                      horizontal: 22.h),
                                                  margin: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: AppColors.grey,
                                                          blurRadius: 4,
                                                          spreadRadius: 2)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.h),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.h),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              data.picture ??
                                                                  "c",
                                                          height: 40.h,
                                                          width: 40.h,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (_, __) =>
                                                                  Image.asset(
                                                            'assets/images/person.png',
                                                            height: 40.h,
                                                            width: 40.h,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget:
                                                              (_, __, ___) =>
                                                                  Image.asset(
                                                            'assets/images/person.png',
                                                            height: 40.h,
                                                            width: 40.h,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 6.h),
                                                      regularText(
                                                        '@${data.brandName}',
                                                        fontSize: 12.sp,
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Expanded(
                                                        child: regularText(
                                                          data.about ?? '',
                                                          fontSize: 8.sp,
                                                          height: 1.8,
                                                          color: AppColors
                                                              .textGrey,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    16.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .lightRed,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.h),
                                                        ),
                                                        child: regularText(
                                                          'VIEW CREATOR',
                                                          fontSize: 10.sp,
                                                          color: AppColors.red,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(height: 24.h),
                                        if (exploreModel.allCreators!.length >
                                            6)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    fIndexNotifier.value = 1,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.center,
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
              )),
    );
  }
}
