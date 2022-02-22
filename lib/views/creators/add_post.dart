import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/viewmodels/post_vm.dart';
import 'package:mms_app/views/widgets/buttons.dart';
import 'package:mms_app/views/widgets/custom_textfield.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';
import 'package:mms_app/views/widgets/utils.dart';

import '../base_view.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.model}) : super(key: key);

  final PostModel model;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();
  File? imageFile;
  int? chosenType;
  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.model.title != null;
    title = TextEditingController(text: widget.model.title);
    message = TextEditingController(text: widget.model.message);
    chosenType = widget.model.type == 'public' ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
        onModelReady: (m) => null,
        builder: (_, PostViewModel model, __) => GestureDetector(
            onTap: Utils.offKeyboard,
            child: Form(
                key: formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      leading: SizedBox(),
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      title:
                          Image.asset('assets/images/logo.png', height: 32.h),
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
                                    color: AppColors.grey,
                                    blurRadius: 6,
                                    spreadRadius: 2)
                              ]),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 24.h),
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              SizedBox(height: 32.h),
                              regularText(
                                isEdit ? 'EDIT POST' : 'ADD POST',
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
                                        borderRadius:
                                            BorderRadius.circular(8.h),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                chosenType == 0
                                                    ? Icons
                                                        .radio_button_checked_outlined
                                                    : Icons
                                                        .radio_button_off_outlined,
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
                                        borderRadius:
                                            BorderRadius.circular(8.h),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                chosenType == 1
                                                    ? Icons
                                                        .radio_button_checked_outlined
                                                    : Icons
                                                        .radio_button_off_outlined,
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
                                controller: title,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (a) {
                                  return Utils.isValidName(a, '"Title"', 3);
                                },
                              ),
                              CustomTextField(
                                title: 'Message',
                                controller: message,
                                maxLines: 15,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (a) {
                                  return Utils.isValidName(a, '"Message"', 10);
                                },
                              ),
                              SizedBox(height: 24.h),
                              if (!isEdit)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 24.h),
                                  child: InkWell(
                                    onTap: getImageGallery,
                                    child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10.h),
                                        dashPattern: [3, 3],
                                        color: AppColors.textGrey,
                                        child: imageFile != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.h),
                                                child: Image.file(
                                                  imageFile!,
                                                  width: ScreenUtil
                                                      .defaultSize.width,
                                                  height: 100.h,
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.h,
                                                    horizontal: 55.h),
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
                                                      'Upload featured picture ',
                                                      fontSize: 12.sp,
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.lightBlack,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                  ),
                                ),
                              buttonWithBorder(isEdit ? 'Update' : 'Publish',
                                  buttonColor: AppColors.red,
                                  fontSize: 14.sp,
                                  height: 52.h,
                                  textColor: AppColors.white,
                                  fontWeight: FontWeight.w700, onTap: () async {
                                autoValidate = true;
                                setState(() {});
                                if (formKey.currentState!.validate()) {
                                  Utils.offKeyboard();
                                  if (isEdit) {
                                    Map<String, dynamic> data = {
                                      'id': widget.model.id,
                                      'title': title.text,
                                      'description': message.text,
                                    };
                                    bool res = await model.updatePost(data);
                                    if (res) {
                                      showSnackBar(context, 'Success',
                                          'Post has been updated');
                                      Navigator.pop(context, data);
                                    }
                                  } else {
                                    Map<String, dynamic> data = {
                                      'title': title.text,
                                      'message': message.text,
                                      'postType': chosenType == 0
                                          ? 'public'
                                          : 'supporters',
                                    };
                                    String? id =
                                        await model.createPost(data, imageFile);
                                    if (id != null) {
                                      data['id'] = id;
                                      showSnackBar(context, 'Success',
                                          'Post has been created');
                                      Navigator.pop(context, data);
                                    }
                                  }
                                }
                              }),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h)
                      ],
                    )))));
  }

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
