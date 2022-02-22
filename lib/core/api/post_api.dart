import 'package:dio/dio.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';
import 'dart:io';
import 'base_api.dart';

class PostApi extends BaseAPI {
  Future<String> createPost(Map<String, dynamic> data, File? imageFile) async {
    String url = imageFile == null ? 'post/noimage' : 'post';

    FormData formData = FormData.fromMap(data);
    if (imageFile != null) {
      formData.files.add(
        MapEntry(
          'image',
          MultipartFile.fromFileSync(imageFile.path,
              filename: imageFile.path.split('/').last),
        ),
      );
    }

    log(data);
    try {
      final Response<dynamic> res =
          await dio().post<dynamic>(url, data: formData);
      log(res.data);
      switch (res.statusCode) {
        case CREATED:
          return res.data['data']['id'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<int> updatePost(Map<String, dynamic> data) async {
    String url = 'post/${data['id']}';
    log(data);
    try {
      final Response<dynamic> res = await dio().patch<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['id'];
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
    String url = 'post';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<PostModel> list = [];
          res.data['data'].forEach((a) {
            list.add(PostModel.fromJson(a));
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
