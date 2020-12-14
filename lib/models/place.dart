import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_types.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_adapters.dart';
import 'package:jasamarga_nde_flutter/hive_helper/fields/place_fields.dart';
import 'package:jasamarga_nde_flutter/models/place_category.dart';

part 'place.g.dart';

@HiveType(typeId: HiveTypes.place, adapterName: HiveAdapters.place)
class Place extends HiveObject {
  Place({
    this.id,
    this.name,
    this.description,
    this.needs,
    this.address,
    this.residentsNumber,
    this.residentsDescription,
    this.status,
    this.placesSlug,
    this.phoneMessage,
    this.phoneCall,
    this.whatsappNumber,
    this.latitude,
    this.longitude,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.placeCategory,
  });

  @HiveField(PlaceFields.id)
  int id;
  @HiveField(PlaceFields.name)
  String name;
  @HiveField(PlaceFields.description)
  String description;
  @HiveField(PlaceFields.needs)
  String needs;
  @HiveField(PlaceFields.address)
  String address;
  @HiveField(PlaceFields.residentsNumber)
  int residentsNumber;
  @HiveField(PlaceFields.residentsDescription)
  String residentsDescription;
  @HiveField(PlaceFields.status)
  String status;
  @HiveField(PlaceFields.placesSlug)
  String placesSlug;
  @HiveField(PlaceFields.phoneMessage)
  String phoneMessage;
  @HiveField(PlaceFields.phoneCall)
  String phoneCall;
  @HiveField(PlaceFields.whatsappNumber)
  String whatsappNumber;
  @HiveField(PlaceFields.latitude)
  double latitude;
  @HiveField(PlaceFields.longitude)
  double longitude;
  @HiveField(PlaceFields.publishedAt)
  DateTime publishedAt;
  @HiveField(PlaceFields.createdAt)
  DateTime createdAt;
  @HiveField(PlaceFields.updatedAt)
  DateTime updatedAt;
  @HiveField(PlaceFields.placeCategory)
  PlaceCategory placeCategory;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        needs: json["needs"] == null ? null : json["needs"],
        address: json["address"] == null ? null : json["address"],
        residentsNumber:
            json["residents_number"] == null ? null : json["residents_number"],
        residentsDescription: json["residents_description"] == null
            ? null
            : json["residents_description"],
        status: json["status"] == null ? null : json["status"],
        placesSlug: json["places_slug"] == null ? null : json["places_slug"],
        phoneMessage:
            json["phone_message"] == null ? null : json["phone_message"],
        phoneCall: json["phone_call"] == null ? null : json["phone_call"],
        whatsappNumber:
            json["whatsapp_number"] == null ? null : json["whatsapp_number"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        placeCategory: json["place_category"] == null
            ? null
            : PlaceCategory.fromJson(json["place_category"]),
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
