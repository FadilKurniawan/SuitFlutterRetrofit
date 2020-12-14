import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jasamarga_nde_flutter/engine/services/sm_request.dart';
import 'package:jasamarga_nde_flutter/engine/services/sm_result.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/secure_storage_manager.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

class APIService {
  static final String _baseUrl = "http://panti.suitdev.com";

  static Future<APILoginResult<User>> login(
      String email, String password) async {
    final apiURL = _baseUrl + "/api/user/login";
    Map<String, Object> parameters = {
      'email': email,
      'password': password,
    };

    final apiResult = await SMRequest.dioPost(apiURL, parameters);
    try {
      final json = apiResult.data;
      final jsonCode = json['status'];
      final jsonMessage = json['message'];
      final jsonResult = json['result'];

      if (jsonCode != 200 || jsonResult == null) {
        return Future.error(jsonMessage);
      }

      final jsonUser = jsonResult['user'];
      final jsonToken = jsonResult['token'] ?? '';

      if (jsonToken == '') {
        return Future.error("Token is missing");
      }

      final result = APILoginResult<User>();
      result.code = jsonCode;
      result.message = jsonMessage;
      result.data.token = jsonToken;
      result.data.user = User.fromJson(jsonUser);

      final userId = result.data.user.id;
      await SecureStorageManager.getInstance().setUserId(value: '$userId');
      await SecureStorageManager.getInstance().setToken(value: jsonToken);

      return result;
    } catch (e) {
      print(e.toString());
      return Future.error("Failed to parse response");
    }
  }

  static Future<APIListResult<Place>> getPlaces(
      {int page, int perPage, Map<String, String> parameters}) async {
    final apiUrl = _baseUrl + "/api/places";
    var param = parameters ?? Map<String, String>();
    param['page'] = '$page';
    param['perPage'] = '$perPage';

    final apiResult = await SMRequest.dioGet(apiUrl, param);
    try {
      final json = apiResult.data;
      final jsonCode = json['status'];
      final jsonMessage = json['message'];
      Iterable jsonResult = json['result'];

      if (jsonCode != 200 || jsonResult == null) {
        return Future.error(jsonMessage);
      }

      APIListResult<Place> result = APIListResult();
      result.code = jsonCode;
      result.message = jsonMessage;
      result.data = jsonResult.map((place) => Place.fromJson(place)).toList();

      return result;
    } catch (e) {
      print(e.toString());
      return Future.error("Failed to parse response");
    }
  }

  static Future<APIDetailResult<Place>> getPlaceDetail(
      {int id, Map<String, String> parameters}) async {
    final apiUrl = _baseUrl + "/api/places/$id";
    var param = parameters ?? Map<String, String>();

    final apiResult = await SMRequest.dioGet(apiUrl, param);
    try {
      final json = apiResult.data;
      final jsonCode = json['status'];
      final jsonMessage = json['message'];
      final jsonResult = json['result'];

      if (jsonCode != 200 || jsonResult == null) {
        return Future.error(jsonMessage);
      }

      final result = APIDetailResult<Place>();
      result.code = jsonCode;
      result.message = jsonMessage;
      result.data = Place.fromJson(jsonResult);

      return result;
    } catch (e) {
      print(e.toString());
      return Future.error("Failed to parse response");
    }
  }

  static Future<APIDetailResult<User>> dioUpdateProfile({File picture}) async {
    final apiURL = _baseUrl + "/api/user/profile";
    Map<String, dynamic> parameters = {
      'token': await SecureStorageManager.getInstance().getToken(),
      'picture': await MultipartFile.fromFile(picture.path,
          filename: picture.path.split('/').last),
    };

    final apiResult = await SMRequest.dioPostFormData(apiURL, parameters);
    print("--> dioUpdateProfile: ${apiResult.data.toString()}");
    try {
      final json = apiResult.data;
      final jsonCode = json['status'];
      final jsonMessage = json['message'];
      final jsonResult = json['result'];

      if (jsonCode != 200 || jsonResult == null) {
        return Future.error(jsonMessage);
      }

      final result = APIDetailResult<User>();
      result.code = jsonCode;
      result.message = jsonMessage;
      result.data = User.fromJson(jsonResult);

      // final sqlManager = await SQLiteManager.getInstance();
      // await sqlManager.updateData(result.data, result.data.id);

      return result;
    } catch (e) {
      print(e.toString());
      return Future.error("Failed to parse response");
    }
  }
}
