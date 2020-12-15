import 'package:dio/dio.dart';
import 'package:jasamarga_nde_flutter/engine/services/sm_result.dart';

extension FutureAPIResultExt<T extends APIResult> on Future<T> {
  Future<T> validateResponse() {
    return then((value) {
      // if (value.code == 200) throw Exception('kesalahan disengaja');
      if (value.code >= 200 && value.code <= 299) return value;
      throw 'Terjadi kesalahan. ${value.code} ${value.message}';
    });
  }
}

extension FutureExt<T> on Future<T> {
  Future<T> summarizeError() {
    return catchError((error) {
      switch (error.runtimeType) {
        case DioError:
          final res = (error as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          throw res.statusMessage;
        default:
          print("Got error : ${error.toString()}");
          throw error.toString();
      }
    });
  }

  Future<T> handleError(Function onError) {
    return summarizeError().catchError(onError);
  }
}
