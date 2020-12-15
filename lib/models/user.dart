import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/hive_helper/fields/user_fields.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_adapters.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_types.dart';
import 'package:jasamarga_nde_flutter/models/model_factory.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypes.user, adapterName: HiveAdapters.user)
class User extends HiveObject implements ModelFactory {
  User({
    this.id,
    this.email,
    this.name,
    this.birthdate,
    this.picture,
    this.phoneNumber,
    this.role,
    this.lastVisit,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(UserFields.id)
  int id;
  @HiveField(UserFields.email)
  String email;
  @HiveField(UserFields.name)
  String name;
  @HiveField(UserFields.birthdate)
  String birthdate;
  @HiveField(UserFields.picture)
  String picture;
  @HiveField(UserFields.phoneNumber)
  String phoneNumber;
  @HiveField(UserFields.role)
  String role;
  @HiveField(UserFields.lastVisit)
  DateTime lastVisit;
  @HiveField(UserFields.createdAt)
  DateTime createdAt;
  @HiveField(UserFields.updatedAt)
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        birthdate: json["birthdate"] == null ? null : json["birthdate"],
        picture: json["picture"] == null ? null : json["picture"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        role: json["role"] == null ? null : json["role"],
        lastVisit: json["last_visit"] == null
            ? null
            : DateTime.parse(json["last_visit"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
