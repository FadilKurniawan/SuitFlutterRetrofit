// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sm_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResult _$APIResultFromJson(Map<String, dynamic> json) {
  return APIResult(
    code: json['status'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$APIResultToJson(APIResult instance) => <String, dynamic>{
      'message': instance.message,
      'status': instance.code,
    };

APIDetailResult<T> _$APIDetailResultFromJson<T>(Map<String, dynamic> json) {
  return APIDetailResult<T>(
    message: json['message'],
    data: _Converter<T>().fromJson(json['result']),
  )..code = json['status'] as int;
}

Map<String, dynamic> _$APIDetailResultToJson<T>(APIDetailResult<T> instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.code,
      'result': _Converter<T>().toJson(instance.data),
    };

APIListResult<T> _$APIListResultFromJson<T>(Map<String, dynamic> json) {
  return APIListResult<T>(
    message: json['message'],
    data: (json['result'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  )..code = json['status'] as int;
}

Map<String, dynamic> _$APIListResultToJson<T>(APIListResult<T> instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.code,
      'result': instance.data?.map(_Converter<T>().toJson)?.toList(),
    };

APILoginResult<T> _$APILoginResultFromJson<T>(Map<String, dynamic> json) {
  return APILoginResult<T>(
    message: json['message'],
    data: json['result'] == null
        ? null
        : LoginResult.fromJson(json['result'] as Map<String, dynamic>),
  )..code = json['status'] as int;
}

Map<String, dynamic> _$APILoginResultToJson<T>(APILoginResult<T> instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.code,
      'result': instance.data,
    };

LoginResult<T> _$LoginResultFromJson<T>(Map<String, dynamic> json) {
  return LoginResult<T>()
    ..token = json['token'] as String
    ..user = _Converter<T>().fromJson(json['user']);
}

Map<String, dynamic> _$LoginResultToJson<T>(LoginResult<T> instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': _Converter<T>().toJson(instance.user),
    };
