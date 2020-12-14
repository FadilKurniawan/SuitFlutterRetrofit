import 'package:bloc/bloc.dart';

import '../../initial_app.dart';
import '../user_bloc.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserManager _userManager = UserManager();
  // final PermissionsService _permissionsService = PermissionsService();

  AuthBloc(AuthState initialState) : super(initialState);

  /// How to track the transition
  ///
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print("AUTH BLOC: $transition");
    super.onTransition(transition);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // await _permissionsService.requestLocationPermission(
    //     onPermissionDenied: () {});

    yield AuthInitState();
    await Future.delayed(Duration(milliseconds: 300));
    if (event is AuthAppStartedEvent) {
      /// APP INIT
      ///
      await InitialApp.setup();
      yield* _isLoggedIn();
    } else if (event is AuthLoggedInEvent) {
      /// Login
      ///
      yield* _isLoggedIn();
    } else if (event is AuthLoggedOutEvent || event is AuthTokenExpiredEvent) {
      /// Logout
      ///
      yield AuthUnauthenticatedState();
    } else {
      yield AuthUnauthenticatedState();
    }
  }

  Stream<AuthState> _isLoggedIn() async* {
    // Mock
    // yield AuthAuthenticatedState();
    final isLogin = await _userManager.isLoggedIn();
    if (isLogin) {
      yield AuthAuthenticatedState();
    } else {
      yield AuthUnauthenticatedState();
    }
  }
}
