import '../../Utils/constants.dart';

abstract class BaseServices {
  final String baseUrl = Constant.baseUrl;

  Future<dynamic> getResponse(String url);

  Future<dynamic> postData(String ur);

  Future<dynamic> postDataBody(String url, dynamic data);

  Future<dynamic> postWithAuth(String url, dynamic data, String token);

  Future<dynamic> getWithAuth(String url, String token);

  Future<dynamic> delWithAuth(String url, String token);
}
