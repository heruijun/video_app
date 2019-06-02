import "package:dio/dio.dart";
import 'dart:async';
import 'dart:convert' as Convert;
import 'package:video_app/common/config/API.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _client;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (null == _client) {
      BaseOptions options = new BaseOptions(
        baseUrl: "${API.BASE_URL}",
        connectTimeout: 1000 * 10,
        receiveTimeout: 3000,
      );
      _client = new Dio(options);
    }
  }

  Future<dynamic> get(String uri, {Map<String, String> params}) async {
    Response response;
    if (null != params) {
      response = await _client.get(uri, queryParameters: params);
    } else {
      response = await _client.get(uri);
    }
    return response.data;
  }
}
