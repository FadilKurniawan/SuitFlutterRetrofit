import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/base_detail_cubit_state.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/cubit_refresher_state.dart';
import 'package:jasamarga_nde_flutter/engine/services/rest_client.dart';
import 'package:jasamarga_nde_flutter/engine/services/sm_result_ext.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(int id) : super(PlaceState(id: id)) {
    // If you wanna load the data from cache first, use function loadCache()
    loadCache();
    refresh();
  }

  final _box = Hive.box<Place>(HiveBoxes.places);

  void loadCache() async {
    try {
      Place data = _box.get(state.id);
      emit(state.copyWith(item: data, status: RefresherSatus.success));
    } catch (error) {
      final errorString = error.toString();
      print("ERROR : $errorString");
      emit(state.copyWith(status: RefresherSatus.failed, error: errorString));
    }
  }

  void refresh() async {
    await RestClient(Dio())
        .getDetailPlaces(state.id)
        .validateResponse()
        .then((result) {
      emit(state.copyWith(
        item: result.data,
        status: RefresherSatus.success,
      ));
    }).handleError((error) {
      emit(state.copyWith(
        status: RefresherSatus.failed,
        error: error,
      ));
    });
  }
}
