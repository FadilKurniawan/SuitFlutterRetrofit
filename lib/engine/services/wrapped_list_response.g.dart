// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapped_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrappedListResponse<T> _$WrappedListResponseFromJson<T>(
    Map<String, dynamic> json) {
  return WrappedListResponse<T>(
    status: json['status'] as int,
    message: json['message'] as String,
    result: (json['result'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$WrappedListResponseToJson<T>(
        WrappedListResponse<T> instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'result': instance.result?.map(_Converter<T>().toJson)?.toList(),
    };
