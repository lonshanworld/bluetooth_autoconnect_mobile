import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetooth_autoconnect_mobile_platform_interface.dart';

/// An implementation of [BluetoothAutoconnectMobilePlatform] that uses method channels.
class MethodChannelBluetoothAutoconnectMobile extends BluetoothAutoconnectMobilePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bluetooth_autoconnect_mobile');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
