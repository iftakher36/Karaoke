import 'package:flutter/cupertino.dart';

import '../../Api/app_exception.dart';

class ResData {
  @visibleForTesting
  dynamic returnResponse(var response) async {
    if (response != null) {
      switch (response.statusCode) {
        case 200:
          dynamic responseJson = await response;
          return responseJson;
        case 400:
          dynamic responseJson = await response;
          return responseJson;
        case 401:
          dynamic responseJson = await response;
          return responseJson;
        case 403:
          throw UnauthorisedException("unauthorized");
        case 500:
        default:
          throw FetchDataException('With status code ${response.statusCode}');
      }
    } else {
      throw FetchDataException('No Internet Connection');
    }
  }
}
