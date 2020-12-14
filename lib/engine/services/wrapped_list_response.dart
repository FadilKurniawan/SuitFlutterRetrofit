import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wrapped_list_response.g.dart';

@JsonSerializable()
class WrappedListResponse<T> {
  String message;
  int status;
  @_Converter()
  final List<T> result;

  // T _dataFromJson<T, S, U>(Map<String, dynamic> input, [S other1, U other2]) =>
  //     input['value'] as T;

  // Map<String, dynamic> _dataToJson<T, S, U>(T input, [S other1, U other2]) =>
  //     {'value': input};

  WrappedListResponse({this.status, this.message, this.result});

  factory WrappedListResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$WrappedListResponseFromJson(json);
  Map<dynamic, dynamic> toJson() => _$WrappedListResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('place_category_id') &&
        json.containsKey('place_documents_id')) {
      return Place.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}
