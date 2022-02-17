import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';

import 'base_api.dart';

class AuthApi extends BaseAPI {
  Logger log = Logger();

  Future<bool> signup(Map<String, dynamic> data) async {
    String url = 'auth/new-signup/register';

    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);

      log.d(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return true;
         default:
          throw res.data['message'];
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
