import 'package:dio/dio.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/creator_stat_model.dart';
import 'package:mms_app/core/models/fan_payment_history.dart';
import 'package:mms_app/core/models/payout.dart';
import 'package:mms_app/core/models/user_model.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';
import 'base_api.dart';

class StatApi extends BaseAPI {
  Future<CreatorStat> getCreatorStat() async {
    String url = 'statistic';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return CreatorStat.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Supporters>> getSupporters() async {
    String url = 'statistic/supporters';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<Supporters> list = [];
          res.data['data']['supporters'].forEach((a) {
            list.add(Supporters.fromJson(a));
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
/*

  Future<List<int>> paymentHistory(String email) async {
    String url = 'statistic/payment-history?q=$email';
    print(url);
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
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
*/

  Future<String> initPayout(Map<String, dynamic> data) async {
    String url = 'payout';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['reference'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<PayoutModel>> payoutHistory() async {
    String url = 'payout/history';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<PayoutModel> list = [];
          res.data['data'].forEach((a) {
            list.add(PayoutModel.fromJson(a));
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

  Future<FanPaymentHistoryModel> creatorGetFanSupportHistory(email) async {
    String url = 'statistic/history?email=$email';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return FanPaymentHistoryModel.fromJson(res.data['data']);
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<String> initPayment(Map<String, dynamic> data) async {
    String url = 'payment';
    log(data);
    try {
      final Response<dynamic> res = await dio().post<dynamic>(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          return res.data['data']['reference'];
        default:
          throw res.data['message'];
      }
    } catch (e) {
      log(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> confirmPayment(Map<String, dynamic> data) async {
    String url = 'payment';
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

  Future<List<UserData>> getSupportedCreators() async {
    String url = 'user/support-creators';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<UserData> list = [];
          res.data['data'].forEach((a) {
            list.add(UserData.fromJson(a));
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

  Future<List<UserData>> getExploredCreators() async {
    String url = 'user/creators';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);
      log(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          List<UserData> list = [];
          res.data['data'].forEach((a) {
            list.add(UserData.fromJson(a));
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
