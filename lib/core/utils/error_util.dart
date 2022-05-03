import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/views/auth/choose_signup.dart';
import 'package:mms_app/views/creators/creators_layout.dart';
import 'package:mms_app/views/fan/fan_layout.dart';

import '../../locator.dart';
import 'navigator.dart';

class DioErrorUtil {
  static String handleError(dynamic error) {
    String errorDescription = '';
    if (error is SocketException) {
      errorDescription = 'No internet connection';
    } else if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.connectTimeout:
          errorDescription = 'Slow Connection';
          break;
        case DioErrorType.other:
          errorDescription = 'No internet connection';
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioErrorType.response:
          if (error.response!.statusCode == 404)
            errorDescription =
                error.response!.statusMessage ?? 'Unexpected error occurred';
          else if (error.response!.statusCode == 400) {
            errorDescription = error.response!.statusMessage ?? 'Bad request';
          } else if (error.response!.statusCode == 401) {
            errorDescription = error.response!.statusMessage ??
                'These credentials are wrong \nCheck and try again';
          } else if (error.response!.statusCode == 500) {
            errorDescription = error.response!.statusMessage ??
                'Server is currently under maintenance, Try again later';
          } else {
            errorDescription =
                'Received invalid status code: ${error.response!.statusCode}';
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;
      }
    } else if (error is TypeError) {
      errorDescription = error.stackTrace.toString();
    } else {
      errorDescription = error.toString();
    }

    if (errorDescription == 'Access Denied, Your token is invalid or expired') {
      AppCache.clear();
      fIndexNotifier.value = 0;
      cIndexNotifier.value = 0;
      pushAndRemoveUntil(
          locator<NavigationService>().navigationKey.currentContext!,
          ChooseSignup());
    }

    return errorDescription;
  }
}
