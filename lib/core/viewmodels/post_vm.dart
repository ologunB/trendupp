import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/post_api.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class PostViewModel extends BaseModel {
  final PostApi _postApi = locator<PostApi>();
  String? error;

  Future<PostModel?> createPost(Map<String, dynamic> a, File? file) async {
    setBusy(true);
    try {
      PostModel post = await _postApi.createPost(a, file);
      setBusy(false);
      return post;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return null;
    }
  }

  Future<bool> deletePost(String id) async {
    setBusy(true);
    try {
      await _postApi.deletePost(id);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  Future<void> getPosts(BuildContext context) async {
    setBusy(true);
    creatorsPost = context.read<PostViewModel>().creatorsPost;
    try {
      creatorsPost = await _postApi.getCreatorsPosts();
      creatorsPost!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<PostViewModel>().setCreators(creatorsPost);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<bool> updatePost(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _postApi.updatePost(a);
      setBusy(false);
      return true;
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
      return false;
    }
  }

  int supportersNumber = 0;

  void setSupportersNumber(int data) {
    supportersNumber = data;
    notifyListeners();
  }

  Future<void> supportersByUsername(UserData user, BuildContext context) async {
    setBusy(true);
    try {
      supportersNumber = await _postApi.supportersByUsername(user.userName!);
      context.read<PostViewModel>().setSupportersNumber(supportersNumber);

      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  List<PostModel>? creatorsPost;

  void setCreators(List<PostModel>? data) {
    creatorsPost = data;
    notifyListeners();
  }

  Future<void> postByUsername(UserData user, BuildContext context) async {
    print(context.read<PostViewModel>().creatorsPost?.length);
    setBusy(true);
    if (context.read<PostViewModel>().creatorsPost?.isNotEmpty ?? false) {
      if (context.read<PostViewModel>().creatorsPost?.first.userId == user.id) {
        creatorsPost = context.read<PostViewModel>().creatorsPost;
      }
    }
    try {
      creatorsPost = await _postApi.postByUsername(user);
      creatorsPost!.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      context.read<PostViewModel>().setCreators(creatorsPost);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  BuildContext c() => navigate.navigationKey.currentContext!;

  void showDialog(CustomException e) {
    showSnackBar(
      navigate.navigationKey.currentContext!,
      'Error',
      e.message,
      color: AppColors.red,
    );
  }
}
