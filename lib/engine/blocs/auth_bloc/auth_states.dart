import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthAuthenticatedState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthUnauthenticatedState extends AuthState {
  @override
  List<Object> get props => null;
}