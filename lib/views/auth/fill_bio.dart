import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/views/auth/verify_bank.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

class FillBio extends StatefulWidget {
  const FillBio({Key? key}) : super(key: key);

  @override
  _FillBioState createState() => _FillBioState();
}

class _FillBioState extends State<FillBio> {
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
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemCircle(AppColors.red, isDone: true),
                itemLine(AppColors.red),
                itemCircle(AppColors.red),
                itemLine(AppColors.red),
                itemCircle(AppColors.grey1),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemText('Are you a\ncreator?', MainAxisAlignment.start),
                itemText('User Details', MainAxisAlignment.center),
                itemText('Bank Account\nDetails', MainAxisAlignment.end),
              ],
            ),
          ),
          SizedBox(height: 44.h),
          regularText(
            'You’re almost done!',
            fontSize: 24.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 10.h),
          regularText(
            'Please fill in basic information about yourself\nand the creative work',
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
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
                              color: AppColors.textGrey,
                            ),
                          ],
                        ),
                      )),
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            title: 'Basic Information',
            hintText: 'Brand Name',
            controller: brand,
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
            hintText: 'Creating Piano music,building, Coronarelief  orange..',
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
            'Hey there! I just created a page here. You can now buyacoffee!',
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
            'Complete',
            buttonColor: AppColors.red,
            fontSize: 16.sp,
            height: 52.h,
            textColor: AppColors.white,
            fontWeight: FontWeight.w700,
            onTap: () => push(context, VerifyBank()),
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
