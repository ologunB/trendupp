import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/fan/support_dialog.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, this.data}) : super(key: key);

  final dynamic data;
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
                          'TWYSE’S PAGE',
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
                        child: Image.asset(
                          'assets/images/placeholder.png',
                          height: 40.h,
                        ),
                      ),
                      SizedBox(width: 13.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                              'Twyse Ereme',
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            regularText(
                              'March 2, 2022',
                              fontSize: 10.sp,
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.h),
                    child: Image.asset(
                      'assets/images/placeholder.png',
                      height: 172.h,
                      width: ScreenUtil.defaultSize.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  regularText(
                    'We went on tour in Cairo, Egypt',
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 24.h),
                  regularText(
                    'Lore  Mauris vitae p e t i lus convallis. Eu dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu dolor sit amet, consectetur adipiscing elit. Mauris vitae pellentesque tellus convallis. Eu allis. Eu faucibus augue eu euismod congue nunc, urna. Cursus ac, viverra sit varius nisi, ultricies.',
                    fontSize: 12.sp,
                    height: 1.8,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog<AlertDialog>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) => SupportDialog(),
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
                                'Support Twyse',
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
