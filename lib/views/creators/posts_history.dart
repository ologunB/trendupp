import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/fan/post_details.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

import 'add_post.dart';

class PostsHistory extends StatefulWidget {
  const PostsHistory({Key? key}) : super(key: key);

  @override
  _PostsHistoryState createState() => _PostsHistoryState();
}

class _PostsHistoryState extends State<PostsHistory> {
  bool isEmpty = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      isEmpty = !isEmpty;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.h),
      children: [
        Container(
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
                  'POSTS',
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.h, vertical: 16.h),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'You have not made any posts yet. ',
                          style: GoogleFonts.dmSans(
                            color: AppColors.textGrey,
                            height: 1.8,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                                text: 'Click here to make a post',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.red,
                                  fontSize: 12.sp,
                                  height: 1.8,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    push(context, AddPost());
                                  }),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, __) {
                        return Divider(
                            color: AppColors.textGrey.withOpacity(.4),
                            height: 2.h);
                      },
                      itemCount: 3,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 24.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      regularText(
                                        'French tourists to return to Egypt',
                                        fontSize: 14.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 6.h),
                                        child: regularText(
                                          'Jun 10, 2021 at 02:12 PM',
                                          fontSize: 12.sp,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.h),
                                PopupMenuButton(
                                    onSelected: (int a) {
                                      if (a == 0) {
                                        push(context, PostDetail());
                                      }
                                      if (a == 1) {
                                        push(context, AddPost());
                                      }
                                      if (a == 2) {
                                        showDialog<AlertDialog>(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext cContext) =>
                                              Container(
                                            color: AppColors.darkBlue
                                                .withOpacity(.1),
                                            child: AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              insetPadding: EdgeInsets.zero,
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: ScreenUtil
                                                              .defaultSize
                                                              .width -
                                                          8.h,
                                                      padding:
                                                          EdgeInsets.all(10.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  cContext);
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/close.png',
                                                              width: 28.h,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    regularText(
                                                        'Are you sure you want to\ndelete this?',
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors.black,
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 32.h),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40.h),
                                                      child: buttonWithBorder(
                                                        'Confirm',
                                                        buttonColor:
                                                            AppColors.red,
                                                        fontSize: 14.sp,
                                                        height: 40.h,
                                                        textColor:
                                                            AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        onTap: () {
                                                          Navigator.pop(
                                                              cContext);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 16.h),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40.h),
                                                      child: buttonWithBorder(
                                                        'Cancel',
                                                        fontSize: 14.sp,
                                                        height: 40.h,
                                                        buttonColor:
                                                            AppColors.grey,
                                                        textColor:
                                                            AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        onTap: () {
                                                          Navigator.pop(
                                                              cContext);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 30.h),
                                                  ],
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.h)),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/more.png',
                                      height: 30.h,
                                    ),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<int>>[
                                          PopupMenuItem<int>(
                                            value: 0,
                                            height: 30.h,
                                            child: regularText(
                                              'View Post',
                                              fontSize: 12.sp,
                                              color: AppColors.textGrey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          PopupMenuItem<int>(
                                            value: 1,
                                            height: 30.h,
                                            child: regularText(
                                              'Edit',
                                              fontSize: 12.sp,
                                              color: AppColors.textGrey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          PopupMenuItem<int>(
                                            value: 2,
                                            height: 30.h,
                                            child: regularText(
                                              'Delete',
                                              fontSize: 12.sp,
                                              color: AppColors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ])
                              ],
                            ));
                      }),
            ],
          ),
        ),
      ],
    );
  }
}
