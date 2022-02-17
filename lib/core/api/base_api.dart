import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mms_app/core/storage/local_storage.dart';

class BaseAPI {
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: GlobalConfiguration().get('base_url'),
        sendTimeout: 30000,
        connectTimeout: 50000,
        receiveTimeout: 50000,
        contentType: 'application/json',
        validateStatus: (int? s) => s! < 500,
        headers: {
          'Authorization': 'Bearer ${AppCache?.getIsFirst()}',
        },
      ),
    );
  }
}
