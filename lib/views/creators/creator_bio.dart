import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/viewmodels/auth_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class CreatorBio extends StatefulWidget {
  const CreatorBio({Key? key}) : super(key: key);

  @override
  _CreatorBioState createState() => _CreatorBioState();
}

class _CreatorBioState extends State<CreatorBio> {
  TextEditingController brand = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController whatYouCreate = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController ig = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController fb = TextEditingController();
  TextEditingController websiteUrl = TextEditingController();

  String? imageUrl;
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    UserData user = AppCache.getUser()!;
    brand = TextEditingController(text: user.brandName);
    firstName = TextEditingController(text: user.firstName);
    lastName = TextEditingController(text: user.lastName);
    whatYouCreate = TextEditingController(text: user.creating);
    about = TextEditingController(text: user.about);
    twitter = TextEditingController(text: user.twitterLink);
    ig = TextEditingController(text: user.instagramLink);
    youtube = TextEditingController(text: user.youtubeLink);
    fb = TextEditingController(text: user.facebookLink);
    websiteUrl = TextEditingController(text: user.websiteUrl);
    imageUrl = user.picture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (m) => null,
        builder: (_, AuthViewModel model, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Form(
                key: formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Scaffold(
                  backgroundColor: AppColors.white,
                  appBar: AppBar(
                    elevation: 0,
                    leading: SizedBox(),
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
                        'Update your Details',
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
                                ? Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.h),
                                      child: Image.file(
                                        imageFile!,
                                        width: 100.h,
                                        height: 100.h,
                                      ),
                                    ),
                                  )
                                : imageUrl != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrl!,
                                              height: 100.h,
                                              width: 100.h,
                                              fit: BoxFit.cover,
                                              placeholder: (_, __) =>
                                                  Image.asset(
                                                'assets/images/person.png',
                                                height: 100.h,
                                                width: 100.h,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (BuildContext context,
                                                          String url,
                                                          dynamic error) =>
                                                      Image.asset(
                                                'assets/images/person.png',
                                                height: 100.h,
                                                width: 100.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h, horizontal: 55.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                        hintText: 'Username',
                        controller: brand,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (a) {
                          return Utils.isValidName(a, '"Username"', 2);
                        },
                      ),
                      CustomTextField(
                        hintText: 'First Name',
                        controller: firstName,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (a) {
                          return Utils.isValidName(a, '"First Name"', 2);
                        },
                      ),
                      CustomTextField(
                        hintText: 'Last Name',
                        controller: lastName,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (a) {
                          return Utils.isValidName(a, '"Last Name"', 2);
                        },
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        title: 'What are you creating?',
                        hintText: 'Creating Piano music,building, Coron',
                        controller: whatYouCreate,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (a) {
                          return Utils.isValidName(
                              a, '"What You Creating"', 10);
                        },
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
                        validator: (a) {
                          return Utils.isValidName(a, '"About Me"', 10);
                        },
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
                        hintText: 'username',
                        controller: twitter,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        prefixIcon: prefix('tw'),
                      ),
                      CustomTextField(
                        hintText: 'username',
                        controller: ig,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        prefixIcon: prefix('ig'),
                      ),
                      CustomTextField(
                        hintText: 'username',
                        controller: youtube,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        prefixIcon: prefix('yt'),
                      ),
                      CustomTextField(
                        hintText: 'username',
                        controller: fb,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        prefixIcon: prefix('fb'),
                      ),
                      CustomTextField(
                        hintText: 'website url',
                        controller: websiteUrl,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        prefixIcon: prefix('web'),
                      ),
                      SizedBox(height: 42.h),
                      buttonWithBorder('Update User Details',
                          buttonColor: AppColors.red,
                          fontSize: 16.sp,
                          height: 52.h,
                          busy: model.busy,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w700, onTap: () async {
                        autoValidate = true;
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          Utils.offKeyboard();
                          String? img;
                          if (imageFile != null) {
                            img = await model.uploadImage(imageFile!);
                            if (img == null) return;
                          }
                          Map<String, String> data = {
                            "brandName": brand.text,
                            "firstName": firstName.text,
                            "lastName": lastName.text,
                            "creating": whatYouCreate.text,
                            "about": about.text,
                            "facebookLink": fb.text,
                            "twitterLink": twitter.text,
                            "instagramLink": ig.text,
                            "youtubeLink": youtube.text,
                            "websiteUrl": websiteUrl.text,
                          };
                          if (img != null) {
                            data.putIfAbsent('picture', () => img!);
                          }
                          bool res = await model.updateProfile(data, null);
                          if (res) {
                            showSnackBar(context, 'Success',
                                'Your profile has been updated successfully');
                          }
                        }
                      }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ))));
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

  Widget prefix(String a) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 12.h),
              Image.asset('assets/images/$a.png', height: 20.h),
              SizedBox(width: 8.h),
              regularText(
                a == 'web' ? 'https://' : '@',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ],
          )
        ],
      );
}
