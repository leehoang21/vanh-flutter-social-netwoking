import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> get photoPermission async {
    if (Platform.isIOS) {
      final status = await Permission.photos.status;

      if (status.isDenied) {
        final per = await Permission.photos.request();

        return !(per.isDenied || per.isPermanentlyDenied);
      } else if (status.isPermanentlyDenied) {
        return false;
      } else {
        return true;
      }
    } else {
      final status = await Permission.mediaLibrary.status;

      if (status.isDenied) {
        final per = await Permission.mediaLibrary.request();

        return !(per.isDenied || per.isPermanentlyDenied);
      } else if (status.isPermanentlyDenied) {
        return false;
      } else {
        return true;
      }
    }
  }

  static Future<bool> get checkCameraPermission async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final per = await Permission.camera.request();

      return !(per.isDenied || per.isPermanentlyDenied);
    } else if (status.isPermanentlyDenied) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> get checkStoragePermission async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      final per = await Permission.camera.request();

      return !(per.isDenied || per.isPermanentlyDenied);
    } else if (status.isPermanentlyDenied) {
      return false;
    } else {
      return true;
    }
  }
}
