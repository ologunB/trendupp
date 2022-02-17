import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, this.type}) : super(key: key);

  final int? type;
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  int? chosenType;

  @override
  void initState() {
    chosenType = widget.type;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: SizedBox(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Image.asset('assets/images/logo.png', height: 32.h),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          children: [
            SizedBox(height: 10.h),
            Row(
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
                        'HOME',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.h),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.grey, blurRadius: 6, spreadRadius: 2)
                  ]),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  SizedBox(height: 32.h),
                  regularText(
                    'ADD POST',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          chosenType = 0;
                          setState(() {});
                        },
                        child: Container(
                          height: 100.h,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: chosenType == 0
                                ? AppColors.lightRed
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    chosenType == 0
                                        ? Icons.radio_button_checked_outlined
                                        : Icons.radio_button_off_outlined,
                                    size: 20.h,
                                    color: AppColors.red,
                                  ),
                                  SizedBox(width: 8.h),
                                  regularText(
                                    'Public',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightBlack,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              regularText(
                                'Visible to all your followers and the public',
                                fontSize: 12.sp,
                                color: AppColors.textGrey,
                              ),
                            ],
                          ),
                        ),
                      )),
                      SizedBox(width: 16.h),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          chosenType = 1;
                          setState(() {});
                        },
                        child: Container(
                          height: 100.h,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: chosenType == 1
                                ? AppColors.lightRed
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    chosenType == 1
                                        ? Icons.radio_button_checked_outlined
                                        : Icons.radio_button_off_outlined,
                                    size: 20.h,
                                    color: AppColors.red,
                                  ),
                                  SizedBox(width: 8.h),
                                  regularText(
                                    'Your Supporters',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightBlack,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              regularText(
                                'Visible to your followers only',
                                fontSize: 12.sp,
                                color: AppColors.textGrey,
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    title: 'Title',
                    controller: firstName,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    title: 'Message',
                    controller: lastName,
                    maxLines: 15,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 24.h),
                  InkWell(
                    onTap: getImageGallery,
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.h),
                        dashPattern: [3, 3],
                        color: AppColors.textGrey,
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.h),
                                child: Image.file(
                                  imageFile!,
                                  width: ScreenUtil.defaultSize.width,
                                  height: 100.h,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 55.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 30.h,
                                    ),
                                    Row(),
                                    SizedBox(height: 17.h),
                                    regularText(
                                      'Upload featured picture ',
                                      fontSize: 12.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightBlack,
                                    ),
                                  ],
                                ),
                              )),
                  ),
                  SizedBox(height: 24.h),
                  buttonWithBorder(
                    'Publish',
                    buttonColor: AppColors.red,
                    fontSize: 14.sp,
                    height: 52.h,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            SizedBox(height: 24.h)
          ],
        ));
  }

  File? imageFile;

  Future getImageGallery() async {
    Utils.offKeyboard();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      imageFile = File(result.files.first.path!);
      setState(() {});
    } else {
      return;
    }
  }
}
