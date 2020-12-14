import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DrawerCubit extends Cubit<DrawerCubitState> {
  DrawerCubit() : super(DrawerCubitInitState()) {
    changePage(0);
  }

  void changePage(int page) {
    emit(DrawerCubitChangePageState(page: page));
  }

  void showProfilePage() {
    emit(DrawerCubitInitState());
    emit(DrawerCubitShowProfileState());
  }
}

abstract class DrawerCubitState extends Equatable {
  const DrawerCubitState({this.page});
  final int page;
  @override
  List<Object> get props => [page];
}

class DrawerCubitInitState extends DrawerCubitState {}

class DrawerCubitChangePageState extends DrawerCubitState {
  const DrawerCubitChangePageState({@required int page})
      : assert(page != null),
        super(page: page);
}

class DrawerCubitShowProfileState extends DrawerCubitState {}
