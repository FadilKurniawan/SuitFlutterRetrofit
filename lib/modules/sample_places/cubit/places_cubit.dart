import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/base_pagination_cubit.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/base_pagination_cubit_state.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/cubit_refresher_state.dart';
import 'package:jasamarga_nde_flutter/engine/services/rest_client.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';

part 'places_state.dart';

class PlacesCubit extends BasePaginationCubit<PlacesState> {
  PlacesCubit() : super(PlacesState(status: RefresherSatus.initial)) {
    // loadCache();
    refreshList();
  }

  @override
  void loadCache() async {
    try {
      final _box = Hive.box<Place>(HiveBoxes.places);
      List<Place> data = _box.values.toList();
      emit(state.copyWith(data: data, status: RefresherSatus.success));
    } catch (error) {
      final errorString = error.toString();
      print("ERROR : $errorString");
      emit(state.copyWith(status: RefresherSatus.failed, error: errorString));
    }
  }

  @override
  void onChange(Change<PlacesState> change) {
    print(change.nextState.status);
    super.onChange(change);
  }

  @override
  void refreshNextList() async {
    refreshList(page: state.page + 1);
  }

  @override
  void refreshList({int page = 1}) async {
    emit(state.copyWith(status: RefresherSatus.loading));
    await RestClient(Dio()).getPlacesDefault(page, state.perPage).then((value) {
      print(
          "Got : code ${value.code} -> ${value.message} -> data: ${value.data}");
      if (value.code == 200) {
        try {
          List<Place> data = (state.data != null) ? state.data : List();
          final _box = Hive.box<Place>(HiveBoxes.places);
          if (page == 1) {
            for (var item in value.data) {
              _box.put(item.id, item);
            }
            data.clear();
          }
          data.addAll(value.data);
          emit(state.copyWith(
              data: data,
              hasNext: value.data.isNotEmpty,
              page: page,
              status: RefresherSatus.success));
        } catch (error) {
          final errorString = error.toString();
          print("ERROR : $errorString");
          emit(state.copyWith(
              status: RefresherSatus.failed, error: errorString));
        }
      } else {}
    }).catchError((onError) {
      // non-200 error goes here.
      switch (onError.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (onError as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          emit(state.copyWith(
              status: RefresherSatus.failed, error: res.statusMessage));
          break;
        default:
      }
    });
    // try {
    //   APIListResult<Place> result = await APIService.getPlaces(
    //     page: page,
    //     perPage: state.perPage,
    //   );
    //   final hasNext = result.data.isNotEmpty;

    //   List<Place> data = (state.data != null) ? state.data : List();
    //   final _box = Hive.box<Place>(HiveBoxes.places);
    //   if (page == 1) {
    //     for (var item in result.data) {
    //       _box.put(item.id, item);
    //     }
    //     data.clear();
    //   }
    //   data.addAll(result.data);
    //   emit(state.copyWith(
    //       data: data,
    //       hasNext: hasNext,
    //       page: page,
    //       status: RefresherSatus.success));
    // } catch (error) {
    //   final errorString = error.toString();
    //   print("ERROR : $errorString");
    //   emit(state.copyWith(status: RefresherSatus.failed, error: errorString));
    // }
  }
}
