import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable { }

class AuthAppStartedEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthLoggedInEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthLoggedOutEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthTokenExpiredEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}