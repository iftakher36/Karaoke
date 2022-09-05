import '../Services/base_service.dart';
import '../Services/user_service.dart';

class UserRepo {
  BaseServices baseServices = UserService();

  Future get(String value) async {
    dynamic response = await baseServices.getResponse(value);
    return response;
  }

  Future post(String value) async {
    dynamic response = await baseServices.postData(value);
    return response;
  }

  Future postBody(String value, dynamic data) async {
    dynamic response = await baseServices.postDataBody(value, data);
    return response;
  }

  Future postWithAuth(String value, dynamic data, String token) async {
    dynamic response = await baseServices.postWithAuth(value, data, token);
    return response;
  }

  Future getWithAuth(String value, String token) async {
    dynamic response = await baseServices.getWithAuth(value, token);
    return response;

  }
  Future deleteWithAuth(String value, String token) async {
    dynamic response = await baseServices.delWithAuth(value, token);
    return response;
  }
}
