import 'package:dio/dio.dart';

import '../../Utils/constants.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ));

  static Dio get client {
    return _dio;
  }
}
