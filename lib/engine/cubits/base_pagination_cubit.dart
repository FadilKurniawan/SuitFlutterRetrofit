import 'package:bloc/bloc.dart';

abstract class BasePaginationCubit<T> extends Cubit<T> {
  BasePaginationCubit(T state) : super(state);

  void loadCache();
  void refreshList();
  void refreshNextList();

}
