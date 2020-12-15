import 'package:jasamarga_nde_flutter/engine/services/sm_result.dart';
import 'package:jasamarga_nde_flutter/engine/services/wrapped_list_response.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://panti.suitdev.com/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String authToken, String baseUrl}) {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    if (authToken != null) {
      Map<String, dynamic> headersToken = {'Authorization': authToken};
      headers.addAll(headersToken);
    }

    dio.options = BaseOptions(
        receiveTimeout: 30000, connectTimeout: 30000, headers: headers);

    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("user/login")
  @FormUrlEncoded()
  Future<APILoginResult<User>> login(
      @Field("email") String email, @Field("password") String password);

  @GET("places")
  Future<APIListResult<Place>> getPlacesDefault(
      @Query("page") int page, @Query("perPage") int perPage);

  @GET("places")
  Future<WrappedListResponse<Place>> getPlaces(
      @Field("page") int page, @Field("perPage") int perPage);

  @GET("places/{id}")
  Future<APIDetailResult<Place>> getDetailPlaces(@Path("id") int id);

  @POST("user/profile")
  @FormUrlEncoded()
  Future<APIListResult<Place>> updateProfilePict(
      @MultiPart() MultipartFile picture);
}
