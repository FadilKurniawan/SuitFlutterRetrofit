import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sm_result.g.dart';

@JsonSerializable()
class APIResult {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "status")
  int code;

  APIResult({this.code, this.message});

  factory APIResult.fromJson(Map<dynamic, dynamic> json) =>
      _$APIResultFromJson(json);
  Map<dynamic, dynamic> toJson() => _$APIResultToJson(this);
}

@JsonSerializable()
class APIDetailResult<T> extends APIResult {
  @JsonKey(name: "result")
  @_Converter()
  T data;

  APIDetailResult({status, message, this.data});

  factory APIDetailResult.fromJson(Map<dynamic, dynamic> json) =>
      _$APIDetailResultFromJson(json);
  Map<dynamic, dynamic> toJson() => _$APIDetailResultToJson(this);
}

@JsonSerializable()
class APIListResult<T> extends APIResult {
  @JsonKey(name: "result")
  @_Converter()
  List<T> data;

  APIListResult({status, message, this.data});

  factory APIListResult.fromJson(Map<dynamic, dynamic> json) =>
      _$APIListResultFromJson(json);
  Map<dynamic, dynamic> toJson() => _$APIListResultToJson(this);
}

@JsonSerializable()
class APILoginResult<T> extends APIResult {
  @JsonKey(name: "result")
  @_Converter()
  LoginResult<T> data;

  APILoginResult({status, message, this.data});

  factory APILoginResult.fromJson(Map<dynamic, dynamic> json) =>
      _$APILoginResultFromJson(json);
  Map<dynamic, dynamic> toJson() => _$APILoginResultToJson(this);
}

@JsonSerializable()
class LoginResult<T> {
  @JsonKey(name: "token")
  String token;

  @JsonKey(name: "user")
  @_Converter()
  T user;

  LoginResult();

  factory LoginResult.fromJson(Map<dynamic, dynamic> json) =>
      _$LoginResultFromJson(json);
  Map<dynamic, dynamic> toJson() => _$LoginResultToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('place_category_id') &&
        json.containsKey('place_documents_id')) {
      return Place.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('username') &&
        json.containsKey('email')) {
      return User.fromJson(json) as T;
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
