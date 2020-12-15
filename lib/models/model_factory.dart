import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/place_category.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    switch (type) {
      case User:
        return User.fromJson(json);
      case Place:
        return Place.fromJson(json);
      case PlaceCategory:
        return PlaceCategory.fromJson(json);
      default:
        throw UnimplementedError('`$type` factory unimplemented.');
    }
  }
}
