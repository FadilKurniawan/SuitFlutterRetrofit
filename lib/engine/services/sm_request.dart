import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SMRequest {
  static Future<Response> get({
    @required String urlString,
    Map<String, String> parameters,
  }) async {
    var url = urlString;
    if (parameters != null && parameters.length > 0) {
      url += '?';
      parameters.forEach(
        (key, value) {
          url += key + '=' + value + '&';
        },
      );
      url = url.replaceRange(url.length - 1, url.length, '');
    }
    print('[GET] $url');
    return await http.get(url).timeout(
      const Duration(seconds: 90),
      onTimeout: () {
        return Future.error("Request time out!");
      },
    );
  }

  /// HTTP Version
  ///
  static Future<http.Response> post(
    String apiURL,
    Map<String, Object> parameters,
  ) async {
    print('[POST] $apiURL');
    print('[PARAMS] $parameters');
    return await http.post(apiURL, body: parameters).timeout(
      const Duration(seconds: 90),
      onTimeout: () {
        return Future.error("Request time out!");
      },
    );
  }

  /// DIO Version
  ///
  static Future<dio.Response> dioGet(
    String urlString,
    Map<String, dynamic> parameters,
  ) async {
    print("[GET] $urlString");
    print("[PARAMS] ${parameters.toString()}");
    try {
      return await dio.Dio().get(urlString, queryParameters: parameters, options: dio.Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            // headers: headers,
          ));
    } on dio.DioError catch (e) {
      print(e.toString());
      return Future.error("Something went wrong\n" + e.toString());
    }
  }

  static Future<dio.Response> dioPost(
    String apiURL,
    Map<String, dynamic> parameters,
  ) async {
    print('[POST] $apiURL');
    print('[PARAMS] $parameters');
    try {
      return await dio.Dio().post(apiURL, queryParameters: parameters);
    } on dio.DioError catch (e) {
      return Future.error("Something went wrong\n" + e.toString());
    }
  }

  static Future<dio.Response> dioPostFormData(
      String apiURL, Map<String, dynamic> parameters) async {
    var formData = dio.FormData.fromMap(parameters);
    print('[POST] $apiURL');
    print('[FORM_DATA_FIELDS] ${formData.fields.toString()}');
    print('[FORM_DATA_FILES] ${formData.files.toString()}');
    try {
      return await dio.Dio().post(apiURL, data: formData);
    } on dio.DioError catch (e) {
      return Future.error("Something went wrong\n" + e.toString());
    }
  }
}
