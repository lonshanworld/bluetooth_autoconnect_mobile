// import 'package:flutter_test/flutter_test.dart';
// import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile.dart';
// import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile_platform_interface.dart';
// import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockBluetoothAutoconnectMobilePlatform
//     with MockPlatformInterfaceMixin
//     implements BluetoothAutoconnectMobilePlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final BluetoothAutoconnectMobilePlatform initialPlatform = BluetoothAutoconnectMobilePlatform.instance;
//
//   test('$MethodChannelBluetoothAutoconnectMobile is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelBluetoothAutoconnectMobile>());
//   });
//
//   test('getPlatformVersion', () async {
//     BluetoothAutoconnectMobile bluetoothAutoconnectMobilePlugin = BluetoothAutoconnectMobile();
//     MockBluetoothAutoconnectMobilePlatform fakePlatform = MockBluetoothAutoconnectMobilePlatform();
//     BluetoothAutoconnectMobilePlatform.instance = fakePlatform;
//
//     // expect(await bluetoothAutoconnectMobilePlugin.getPlatformVersion(), '42');
//   });
// }
