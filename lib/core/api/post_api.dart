import 'package:dio/dio.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/post_model.dart';
import 'package:mms_app/core/models/user_model.dart';
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

  Future<List<PostModel>> getFanPosts(String email) async {
    String url = 'post/fanpost?email=$email';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<PostModel> list = [];
          res.data['data'].forEach((a) {
            PostModel post = PostModel.fromJson(a);
            post.userImage = post.user?.picture;
            post.hidden = false;
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

  Future<List<PostModel>> getCreatorsPosts() async {
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
            post.hidden = false;
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

  Future<bool> userSupportsCreator(UserData user) async {
    String url = 'user/check-is-fan';
    Map<String, String> data = {
      "fanEmail": AppCache.getUser()!.email!,
      "creatorEmail": user.email!
    };
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['status'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<PostModel>> postByUsername(UserData user) async {
    String url = 'post?username=${user.userName}';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          bool isFan = await userSupportsCreator(user);
          List<PostModel> list = [];
          res.data['data'].forEach((a) {
            PostModel post = PostModel.fromJson(a);
            post.hidden = post.postType == 'public' ? false : !isFan;
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

  Future<int> supportersByUsername(String user) async {
    String url = 'statistic/$user';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['supporters_number'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
