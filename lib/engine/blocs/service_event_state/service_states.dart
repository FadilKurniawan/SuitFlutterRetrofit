import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ServiceState extends Equatable { }

class ServiceInitState extends ServiceState {

  @override
  String toString() => 'Initial State';

  @override
  List<Object> get props => null;
}

class ServiceLoadingState extends ServiceState {

  @override
  String toString() => '[ServiceLoadingState]';

  @override
  List<Object> get props => null;
}

class ServiceSuccessState<T> extends ServiceState {
  final T result;

  ServiceSuccessState(this.result);

  @override
  String toString() => 'Success: { result: $result }';

  @override
  List<Object> get props => [result];
}

class ServiceFailureState extends ServiceState {
  final String error;
  ServiceFailureState({@required this.error});

  @override
  String toString() => 'Failure: { error: $error }';

  @override
  List<Object> get props => [error];
}

class ServiceShimmerState extends ServiceState {
  @override
  List<Object> get props => [];
}