import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/models/place_category.dart';

void registerAdapters() {
  
	Hive.registerAdapter(UserAdapter());
	Hive.registerAdapter(PlaceAdapter());
	Hive.registerAdapter(PlaceCategoryAdapter());
}
