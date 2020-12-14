import 'package:equatable/equatable.dart';

import 'cubit_refresher_state.dart';

class BasePaginationCubitState<T> extends Equatable {
  const BasePaginationCubitState({
    this.data,
    this.hasNext = false,
    this.perPage = 10,
    this.page = 1,
    this.status = RefresherSatus.initial,
    this.error,
  });

  final List<T> data;
  final bool hasNext;
  final int perPage;
  final int page;
  final RefresherSatus status;
  final String error;

  @override
  List<Object> get props => [data, hasNext, perPage, page, status, error];
}
