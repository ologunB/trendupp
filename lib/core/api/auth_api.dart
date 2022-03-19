import 'package:dio/dio.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';
import 'dart:io';
import 'base_api.dart';

class AuthApi extends BaseAPI {
  Future<String> socialCheck(Map<String, dynamic> data) async {
    String url = 'user/social-check';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['message'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<UserData> socialSignup(Map<String, dynamic> data) async {
    String url = 'user/social-signup';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case CREATED:
          return UserData.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<UserData> socialLogin(Map<String, dynamic> data) async {
    String url = 'user/social-login';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return UserData.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<int> signup(Map<String, dynamic> data) async {
    String url = 'user/signup';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
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

  Future<UserData> login(Map<String, dynamic> data) async {
    String url = 'user/login';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return UserData.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<String> verify(Map<String, dynamic> data) async {
    String url = 'user/verify';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['token'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> resendOtp(Map<String, dynamic> data) async {
    String url = 'user/resend-code';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
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

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    String url = 'user';
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

  Future<String> uploadImage(File imageFile) async {
    String url = 'user/image';
    FormData data = FormData();
    data.files.add(
      MapEntry(
        'picture',
        MultipartFile.fromFileSync(imageFile.path,
            filename: imageFile.path.split('/').last),
      ),
    );
    try {
      final Response<dynamic> res = await dio().patch<dynamic>(url,
          data: data,
          options: Options(
            contentType: 'multipart/form-data',
          ));
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<UserData> getAccount() async {
    String url = 'user';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return UserData.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> changePassword(Map<String, dynamic> data) async {
    String url = 'user/reset';
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

  Future<bool> forgotPassword(Map<String, dynamic> data) async {
    String url = 'user/forgot-password';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
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

  Future<bool> checkLink(String a) async {
    String url = 'user/checkUser';
    try {
      final Response<dynamic> res =
          await dio().post<dynamic>(url, data: {'username': a});
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data'] ;
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<String> resolveAccount(String number, String bCode) async {
    String url =
        'https://api.paystack.co/bank/resolve?account_number=$number&bank_code=$bCode';
    try {
      final Response<dynamic> res = await Dio().get<dynamic>(url,
          options: Options(
            contentType: 'application/json',
            validateStatus: (int? s) => s! < 500,
            headers: {
              'Authorization':
                  'Bearer sk_test_a8e83e26c857b2534f9e5ed84a8e49b9716ebb69',
            },
          ));
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['account_name'].toUpperCase();
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
