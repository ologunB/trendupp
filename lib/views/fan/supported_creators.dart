import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/viewmodels/stat_api.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/creator_item.dart';
import 'package:mms_app/views/widgets/empty_widget.dart';
import 'package:mms_app/views/widgets/error_widget.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../base_view.dart';

class SupportedCreators extends StatefulWidget {
  const SupportedCreators({Key? key}) : super(key: key);

  @override
  _SupportedCreatorsState createState() => _SupportedCreatorsState();
}

class _SupportedCreatorsState extends State<SupportedCreators> {
  TextEditingController search = TextEditingController();

  bool isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<StatViewModel>(
        onModelReady: (m) => m.getSupportedCreators(''),
        builder: (_, StatViewModel historyModel, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Column(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 8.h),
                    shrinkWrap: true,
                    children: [
                      historyModel.busy
                          ? GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: Utils.gridDelegate(),
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: 6,
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
                          : historyModel.allSupportedCreators == null
                              ? ErrorOccurredWidget(
                                  error: historyModel.error,
                                  onPressed: () {
                                    historyModel.getSupportedCreators('email');
                                  },
                                )
                              : historyModel.allSupportedCreators!.isEmpty
                                  ? AppEmptyWidget('No creators are available')
                                  : GridView.builder(
                                      gridDelegate: Utils.gridDelegate(),
                                      itemCount: historyModel
                                          .allSupportedCreators!.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (ctx, i) {
                                        dynamic c = historyModel
                                            .allSupportedCreators![i];
                                        return creatorItem(ctx, c);
                                      }),
                      SizedBox(height: 24.h),
                      if (historyModel.allExploredCreators != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoadingMore
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.red),
                                    ),
                                    height: 20.h,
                                    width: 20.h,
                                  )
                                : InkWell(
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
                                          'View more',
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
            )));
  }
}
