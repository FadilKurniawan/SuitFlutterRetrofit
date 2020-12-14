part of 'place_cubit.dart';

class PlaceState extends BaseDetailCubitState<Place> {
  const PlaceState({
    @required int id,
    Place item,
    RefresherSatus status,
    String error,
  })  : assert(id != null),
        super(
          id: id,
          item: item,
          status: status,
          error: error,
        );

  PlaceState copyWith({
    int id,
    Place item,
    RefresherSatus status,
    String error,
  }) {
    return PlaceState(
      id: id ?? this.id,
      item: item ?? this.item,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}