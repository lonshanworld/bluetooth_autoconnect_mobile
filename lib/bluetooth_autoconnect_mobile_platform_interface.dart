import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bluetooth_autoconnect_mobile_method_channel.dart';

abstract class BluetoothAutoconnectMobilePlatform extends PlatformInterface {
  /// Constructs a BluetoothAutoconnectMobilePlatform.
  BluetoothAutoconnectMobilePlatform() : super(token: _token);

  static final Object _token = Object();

  static BluetoothAutoconnectMobilePlatform _instance = MethodChannelBluetoothAutoconnectMobile();

  /// The default instance of [BluetoothAutoconnectMobilePlatform] to use.
  ///
  /// Defaults to [MethodChannelBluetoothAutoconnectMobile].
  static BluetoothAutoconnectMobilePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BluetoothAutoconnectMobilePlatform] when
  /// they register themselves.
  static set instance(BluetoothAutoconnectMobilePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
