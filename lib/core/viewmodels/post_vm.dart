import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/core/api/post_api.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/views/widgets/snackbar.dart';
import '../../locator.dart';
import 'base_vm.dart';
import 'dart:io';

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

  List<PostModel>? allPosts;

  Future<void> getPosts() async {
    setBusy(true);
    try {
      allPosts = await _postApi.getCreatorsPosts();
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

  List<PostModel>? creatorsPost;

  Future<void> postByUsername(String user) async {
    setBusy(true);
    try {
      creatorsPost = await _postApi.postByUsername(user);
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
