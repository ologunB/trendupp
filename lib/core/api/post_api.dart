import 'package:dio/dio.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';
import 'dart:io';
import 'base_api.dart';

class PostApi extends BaseAPI {
  Future<PostModel> createPost(
      Map<String, dynamic> data, File? imageFile) async {
    String url = imageFile == null ? 'post/noimage' : 'post';

    dynamic formData;
    if (imageFile != null) {
      formData = FormData.fromMap(data);
      formData.files.add(
        MapEntry(
          'image',
          MultipartFile.fromFileSync(imageFile.path,
              filename: imageFile.path.split('/').last),
        ),
      );
    } else {
      formData = data;
    }

    log(data);
    try {
      final Response<dynamic> res =
          await dio().post<dynamic>(url, data: formData);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return PostModel.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> updatePost(Map<String, dynamic> data) async {
    String url = 'post/${data['id']}';
    log(data);
    try {
      final Response<dynamic> res = await dio().patch<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return true;
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> deletePost(String id) async {
    String url = 'post/$id';
    try {
      final Response<dynamic> res = await dio().delete<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return true;
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<PostModel>> getPosts() async {
    String url = 'post/all';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<PostModel> list = [];
          res.data['data'].forEach((a) {
            PostModel post = PostModel.fromJson(a);
            post.userImage = AppCache.getUser()!.picture;
            post.userName = AppCache.getUser()!.firstName;
            list.add(post);
          });
          return list;
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
