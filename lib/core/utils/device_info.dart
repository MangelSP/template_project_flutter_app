import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceType() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final deviceData = Platform.isAndroid
          ? await deviceInfo.androidInfo
          : await deviceInfo.iosInfo;
      return deviceData is AndroidDeviceInfo ? 'Phone' : 'iPhone';
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'Desktop';
    } else if (kIsWeb) {
      return 'Web';
    }
    return 'Unknown';
  }
}
