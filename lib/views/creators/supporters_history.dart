import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/viewmodels/stat_vm.dart';
import 'package:mms_app/views/widgets/card_item.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/supporter_item.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../base_view.dart';

class SupportersHistory extends StatefulWidget {
  const SupportersHistory({Key? key}) : super(key: key);

  @override
  _SupportersHistoryState createState() => _SupportersHistoryState();
}

class _SupportersHistoryState extends State<SupportersHistory> {
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
        onModelReady: (m) => m.getSupporters(context),
        builder: (_, StatViewModel model, __) => Scaffold(
              floatingActionButton: !_showBackToTopButton
                  ? null
                  : FloatingActionButton(
                      backgroundColor: AppColors.red,
                      onPressed: _scrollToTop,
                      child: Icon(Icons.keyboard_arrow_up),
                      tooltip: 'Scroll to up',
                    ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
                children: [
                  cardItem(
                      'love1',
                      model.allSupporters?.length.toString() ?? '0',
                      'Supporters',
                      Color(0xffFCEFE7),
                      Color(0xffF09A4A)),
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
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.h),
                          child: regularText(
                            'TIPPERS',
                            fontSize: 14.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        model.busy && model.allSupporters == null
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15.h),
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(.1),
                                      highlightColor: Colors.white60,
                                      child: Container(
                                        height: 60.h,
                                        margin: EdgeInsets.only(top: 8.h),
                                        width: ScreenUtil.defaultSize.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(5.h),
                                        ),
                                      ));
                                })
                            : model.allSupporters == null
                                ? ErrorOccurredWidget(
                                    error: model.error,
                                    onPressed: () {
                                      model.getSupporters(context);
                                    },
                                  )
                                : model.allSupporters!.isEmpty
                                    ? AppEmptyWidget(
                                        'No tippers yet, share link')
                                    : ListView.separated(
                                        separatorBuilder: (_, __) {
                                          return Divider(
                                              color: AppColors.textGrey
                                                  .withOpacity(.4),
                                              height: 2.h);
                                        },
                                        itemCount: model.allSupporters!.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext ctx, i) {
                                          Supporters support =
                                              model.allSupporters![i];
                                          return SupporterItem(support);
                                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ));
  }
}
