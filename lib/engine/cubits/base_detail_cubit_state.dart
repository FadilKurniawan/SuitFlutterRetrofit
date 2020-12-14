import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'cubit_refresher_state.dart';

class BaseDetailCubitState<T> extends Equatable {
  const BaseDetailCubitState(
      {@required this.id,
      this.item,
      this.status = RefresherSatus.initial,
      this.error});

  final int id;
  final T item;
  final RefresherSatus status;
  final String error;

  @override
  List<Object> get props => [id, item, status, error];
}
