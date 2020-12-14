import 'package:flutter/material.dart';

class SMError {

  const SMError({@required int code, @required String message}) : _code = code, _message = message;

  final int _code;
  final String _message;

  int getCode() {
    return _code;
  }

  String getMessage() {
    return _message;
  }
}

class LoginError extends SMError {
  // Normal Constructor
  // const LoginError({int code, String message}) : super(code: code, message: message);

  const LoginError.unknownError()
      : super(code: 0, message: "Something went wrong!"); // unknown Error
  const LoginError.invalidEmail()
      : super(code: 310, message: "The email address is invalid");
  const LoginError.emptyEmail()
      : super(code: 311, message: "The email address is required");
  const LoginError.invalidMinumumPassword()
      : super(code: 320, message: "The password must contain at least 4 characters");
  const LoginError.emptyPassword()
      : super(code: 321, message: "The password is required");
}