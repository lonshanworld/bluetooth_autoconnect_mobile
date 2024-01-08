
import 'bluetooth_autoconnect_mobile_platform_interface.dart';

class BluetoothAutoconnectMobile {
  Future<String?> getPlatformVersion() {
    return BluetoothAutoconnectMobilePlatform.instance.getPlatformVersion();
  }
}
