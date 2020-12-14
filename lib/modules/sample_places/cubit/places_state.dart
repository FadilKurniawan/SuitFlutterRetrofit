part of 'places_cubit.dart';

class PlacesState extends BasePaginationCubitState<Place> {
  const PlacesState({
    List<Place> data,
    bool hasNext = false,
    int perPage = 10,
    int page = 1,
    RefresherSatus status,
    String error,
  }) : super(
          data: data,
          hasNext: hasNext,
          perPage: perPage,
          page: page,
          status: status,
          error: error,
        );

  PlacesState copyWith({
    List<Place> data,
    bool hasNext,
    int perPage,
    int page,
    RefresherSatus status,
    String error,
  }) {
    return PlacesState(
      data: data ?? this.data,
      hasNext: hasNext ?? this.hasNext,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
