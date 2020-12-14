import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/user_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/services/api_service.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/service_event_state/service_events.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/service_event_state/service_states.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/secure_storage_manager.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

class ProfileBloc extends Bloc<ServiceEvent, ServiceState> {
  final _userManager = UserManager();

  ProfileBloc(ServiceState initialState) : super(initialState);

  ServiceState get initialState => ServiceInitState();

  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is LoadCurrentUserEvent) {
      final user = await _userManager.getCurrentUser();
      yield LoadedCurrentUserState(user: user);
    }

    if (event is LogoutUserEvent) {
      yield ServiceLoadingState();
      // API LOGOUT
      await Future.delayed(Duration(milliseconds: 300));
      await _logoutClearData();
      yield LoggedOutUserState();
    }

    if (event is UpdateUserEvent) {
      yield* _mapUpdateUserToState(picture: event.picture);
    }
  }

  _logoutClearData() async {
    final _box = Hive.box<User>(HiveBoxes.users);
    final currentUserId = await SecureStorageManager.getInstance().getUserId();
    _box.delete(currentUserId);
    await SecureStorageManager.getInstance().setToken(value: "");
  }

  Stream<ServiceState> _mapUpdateUserToState({File picture}) async* {
    yield ServiceLoadingState();
    try {
      var result = await APIService.dioUpdateProfile(
        picture: picture,
      );
      yield ServiceSuccessState<User>(result.data);
    } catch (e) {
      yield ServiceFailureState(error: e.toString());
    }
  }
}

class LoadCurrentUserEvent extends ServiceEvent {
  @override
  List<Object> get props => null;
}

class LogoutUserEvent extends ServiceEvent {
  @override
  List<Object> get props => null;
}

class UpdateUserEvent extends ServiceEvent {
  final File picture;

  UpdateUserEvent(this.picture);

  @override
  List<Object> get props => [picture];
}

class LoadedCurrentUserState extends ServiceState {
  final User user;

  LoadedCurrentUserState({this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOutUserState extends ServiceState {
  @override
  List<Object> get props => null;
}
