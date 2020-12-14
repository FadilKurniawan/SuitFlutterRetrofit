import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_types.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_adapters.dart';
import 'package:jasamarga_nde_flutter/hive_helper/fields/place_category_fields.dart';


part 'place_category.g.dart';


@HiveType(typeId: HiveTypes.placeCategory, adapterName: HiveAdapters.placeCategory)
class PlaceCategory extends HiveObject{
    PlaceCategory({
        this.id,
        this.name,
        this.placesCategorySlug,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.image,
    });

	@HiveField(PlaceCategoryFields.id)
    int id;
	@HiveField(PlaceCategoryFields.name)
    String name;
	@HiveField(PlaceCategoryFields.placesCategorySlug)
    String placesCategorySlug;
	@HiveField(PlaceCategoryFields.publishedAt)
    DateTime publishedAt;
	@HiveField(PlaceCategoryFields.createdAt)
    DateTime createdAt;
	@HiveField(PlaceCategoryFields.updatedAt)
    DateTime updatedAt;
	@HiveField(PlaceCategoryFields.deletedAt)
    dynamic deletedAt;
	@HiveField(PlaceCategoryFields.image)
    String image;

    factory PlaceCategory.fromJson(Map<String, dynamic> json) => PlaceCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        placesCategorySlug: json["places_category_slug"] == null ? null : json["places_category_slug"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        image: json["image"] == null ? null : json["image"],
    );
}