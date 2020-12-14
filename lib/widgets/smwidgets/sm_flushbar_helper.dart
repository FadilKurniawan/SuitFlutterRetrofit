import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SMFlushbarHelper {

static final _duration = 3000;
static final _colorErrorPrimary = Colors.red;
static final _colorErrorSecondary = Colors.yellow;

  static Flushbar errorFlushbar({@required String message}) {
    return Flushbar(
        message: message,
        animationDuration: Duration(milliseconds: 400),
        // flushbarStyle: FlushbarStyle.GROUNDED,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: _colorErrorPrimary,
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: _colorErrorSecondary,
        ),
        duration: Duration(milliseconds: _duration),
        // leftBarIndicatorColor: _colorErrorSecondary,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      );
  }
}