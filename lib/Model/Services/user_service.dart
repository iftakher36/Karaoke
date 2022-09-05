import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:karaoke/Model/DataModel/ResData/res_data.dart';

import '../Api/app_exception.dart';
import '../Api/dio_client.dart';
import 'base_service.dart';

class UserService extends BaseServices {
  @override
  Future getResponse(String url) async {
    dynamic response;
    try {
      final responses = await DioClient.client.get(baseUrl + url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        try {
          response = ResData().returnResponse(e.response);
        } catch (e) {
          throw FetchDataException('No Internet Connection');
        }
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }

  @override
  Future postData(String url) async {
    dynamic response;
    try {
      final responses = await DioClient.client.post(baseUrl + url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        throw FetchDataException('Poor Internet Connection');
      } else if (e.type == DioErrorType.response) {
        response = ResData().returnResponse(e.response);
        return response;
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }

  @override
  Future postDataBody(String url, dynamic data) async {
    dynamic response;
    try {
      final responses = await DioClient.client.post(baseUrl + url,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        throw FetchDataException('Poor Internet Connection');
      } else if (e.type == DioErrorType.response) {
        response = ResData().returnResponse(e.response);
        return response;
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }

  @override
  Future getWithAuth(String url, String token) async {
    dynamic response;
    try {
      final responses = await DioClient.client.get(baseUrl + url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': "Bearer " + token
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        throw FetchDataException('Poor Internet Connection');
      } else if (e.type == DioErrorType.response) {
        response = ResData().returnResponse(e.response);
        return response;
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }

  @override
  Future postWithAuth(String url, data, String token) async {
    dynamic response;
    try {
      final responses = await DioClient.client.post(baseUrl + url,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': "Bearer " + token
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        throw FetchDataException('Poor Internet Connection');
      } else if (e.type == DioErrorType.response) {
        response = ResData().returnResponse(e.response);
        return response;
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }

  @override
  Future delWithAuth(String url, String token) async {
    dynamic response;
    try {
      final responses = await DioClient.client.delete(baseUrl + url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': "Bearer " + token
          }));
      response = ResData().returnResponse(responses);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw FetchDataException('Connection TimeOut');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw FetchDataException('Sending TimeOut');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw FetchDataException('Receive TimeOut');
      } else if (e.type == DioErrorType.other) {
        throw FetchDataException('Poor Internet Connection');
      } else if (e.type == DioErrorType.response) {
        response = ResData().returnResponse(e.response);
        return response;
      } else {
        throw FetchDataException(e.message);
      }
    }
    return response;
  }
}
