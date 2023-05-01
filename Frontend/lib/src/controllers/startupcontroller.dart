import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

Future<bool> requestPermissions(BuildContext context) async {
  // Check if they are on a mobile phone
  if (!Platform.isAndroid && !Platform.isIOS) {
    return true;
  }
  // Request needed permissions
  Map<Permission, PermissionStatus> _ = await [
    Permission.notification,
    Permission.location
  ].request();

  // If location is disabled display an error
  if (await Permission.location.isDenied) {
    return false;
  }

  // If location is enabled go to login screen
  return true;
}
