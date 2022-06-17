import 'package:permission_handler/permission_handler.dart';

class PermissionApp{
  static Future<bool> requestPermission(Permission setting) async {
    // setting.request() will return the status ALWAYS
    // if setting is already requested, it will return the status
    final _result = await setting.request();
    switch (_result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}