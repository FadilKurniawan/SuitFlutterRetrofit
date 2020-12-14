import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({@required Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.locationWhenInUse);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

}