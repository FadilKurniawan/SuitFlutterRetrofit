import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jasamarga_nde_flutter/engine/services/rest_client.dart';
import 'package:jasamarga_nde_flutter/engine/services/sm_result.dart';
import 'package:jasamarga_nde_flutter/engine/utilities/secure_storage_manager.dart';
import 'package:jasamarga_nde_flutter/hive_helper/hive_boxes.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void updateEmail(String email) {
    emit(state.updateStateWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.updateStateWith(password: password));
  }

  void login() async {
    // Mock Login
    // await Future.delayed(Duration(milliseconds: 1000));
    // emit(LoginSuccess());

    emit(LoginInitial.createFrom(state: state));
    await Future.delayed(Duration(milliseconds: 350));
    if (state.email == null || state.email == "") {
      emit(LoginFailed.createFrom(
          state: state, error: "Please fill the Email field"));
    } else if (state.password == null || state.password == "") {
      emit(LoginFailed.createFrom(
          state: state, error: "Please fill the Password field"));
    } else {
      emit(LogingIn.createFrom(state: state));
      await Future.delayed(Duration(milliseconds: 500));
      try {
        // await APIService.login(state.email, state.password);
        APILoginResult<User> result =
            await RestClient(Dio()).login(state.email, state.password);

        if (result.data != null) {
          print("*** get : code ${result.code}, data ${result.message}");
          final userId = result.data.user.id;
          await SecureStorageManager.getInstance().setUserId(value: '$userId');
          await SecureStorageManager.getInstance()
              .setToken(value: result.data.token);
          final box = Hive.box<User>(HiveBoxes.users);
          box.put(result.data.user.id, result.data.user);
          emit(LoginSuccess(user: result.data.user));
        } else {
          print(result.message);
          emit(LoginFailed.createFrom(state: state, error: result.message));
        }
      } catch (error) {
        emit(LoginFailed.createFrom(state: state, error: error.toString()));
      }
    }
  }
}
