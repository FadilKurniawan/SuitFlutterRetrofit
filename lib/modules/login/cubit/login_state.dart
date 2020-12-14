part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({this.email, this.password});

  final String email;
  final String password;

  LoginState updateStateWith({String email, String password}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class LoginInitial extends LoginState {
  const LoginInitial({String email, String password}) : super(email: email, password: password);

  static LoginInitial createFrom({@required LoginState state}) {
    return LoginInitial(email: state.email, password: state.password);
  }

  @override
  List<Object> get props => [];
}

class LogingIn extends LoginState {
  const LogingIn({String email, String password}) : super(email: email, password: password);

  static LogingIn createFrom({@required LoginState state}) {
    return LogingIn(email: state.email, password: state.password);
  }

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess({this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class LoginFailed extends LoginState {
  const LoginFailed({this.error, String email, String password}) : super(email: email, password: password);

  final String error;

  static LoginFailed createFrom({@required LoginState state, @required String error}) {
    return LoginFailed(error: error, email: state.email, password: state.password);
  }

  @override
  List<Object> get props => [error];
}
