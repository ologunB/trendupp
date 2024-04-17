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
    String errorDescription = 'An error happened';

    if (error is DioException) {
      errorDescription = error.message ?? 'An unknown error happened';
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to server was cancelled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Slow Connection';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'No internet connection';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Failed to receive data from server';
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Failed to send data to server';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Server Bad Certificate';
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Bad Response';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Failed to connect to server';
          break;
      }
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

class LendoException implements Exception {
  LendoException(this.message);
  String message;
}
