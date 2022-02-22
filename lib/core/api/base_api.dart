import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/core/storage/local_storage.dart';

class BaseAPI {
  Dio dio() {
    Dio dio = new Dio(
      BaseOptions(
        baseUrl: GlobalConfiguration().get('base_url'),
        sendTimeout: 30000,
        connectTimeout: 500000,
        receiveTimeout: 50000,
        contentType: 'application/json',
        validateStatus: (int? s) => s! < 500,
        headers: {
          'Authorization': 'Bearer ${AppCache.getToken()}',
        },
      ),
    );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  log(dynamic data) {
    Logger l = Logger();
    l.d(data);
  }
}
