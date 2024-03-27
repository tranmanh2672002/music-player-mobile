import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceProvider extends ChangeNotifier {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // getter
  Future<String> getDeviceId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }
}
