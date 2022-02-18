import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class CreatorBio extends StatefulWidget {
  const CreatorBio({Key? key}) : super(key: key);

  @override
  _CreatorBioState createState() => _CreatorBioState();
}

class _CreatorBioState extends State<CreatorBio> {
  TextEditingController brand = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController whatYouCreate = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController ig = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController fb = TextEditingController();
  TextEditingController websiteUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,        leading: SizedBox(),

        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32.h),
      ),
      body: ListView(
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
                      'SETTINGS',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          regularText(
            'Update User Details',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 32.h),
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
                              'Upload profile picture',
                              fontSize: 12.sp,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightBlack,
                            ),
                          ],
                        ),
                      )),
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            title: 'Basic Information',
            hintText: 'Brand Name',
            controller: firstName,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            hintText: 'First Name',
            controller: firstName,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            hintText: 'Last Name',
            controller: lastName,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            hintText: 'Website URL',
            controller: website,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            title: 'What are you creating?',
            hintText: 'Creating Piano music,building, Coron',
            controller: whatYouCreate,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            title: 'About me',
            hintText:
                'Hey there! I just created a page here. You can\nnow buyacoffee!',
            controller: about,
            maxLines: 3,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 24.h),
          regularText(
            'Social Platforms',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 8.h),
          regularText(
            'Enter the username of the social media platforms\nyou are on',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: '@username',
            controller: twitter,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/tw.png', height: 20.h),
              ],
            ),
          ),
          CustomTextField(
            hintText: '@username',
            controller: ig,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/ig.png', height: 20.h),
              ],
            ),
          ),
          CustomTextField(
            hintText: '@username',
            controller: youtube,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/yt.png', height: 20.h),
              ],
            ),
          ),
          CustomTextField(
            hintText: '@username',
            controller: fb,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/fb.png', height: 20.h),
              ],
            ),
          ),
          CustomTextField(
            hintText: 'website url',
            controller: websiteUrl,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/web.png', height: 20.h),
              ],
            ),
          ),
          SizedBox(height: 42.h),
          buttonWithBorder(
            'Update User Details',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
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
