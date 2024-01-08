library bluetooth_autoconnect_mobile;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';


class BluetoothAutoconnectMobile extends ChangeNotifier{
  // Future<String?> getPlatformVersion() {
  //   return BluetoothAutoconnectMobilePlatform.instance.getPlatformVersion();
  // }

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _address = "...";
  String _name = "...";
  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;
  bool _autoAcceptPairingRequests = true;

  BluetoothState get bluetoothState => _bluetoothState;
  String get address => _address;
  String get name => _name;

  void initBluetoothService(){
    FlutterBluetoothSerial.instance.state.then((value) {
      print(value);
      _bluetoothState = value;
      notifyListeners();
    });
    FlutterBluetoothSerial.instance.onStateChanged().listen((event) {
      _bluetoothState = event;
      print(event);
      notifyListeners();
    });
  }

  void connectBluetooth()async{
    BluetoothConnection connection = await BluetoothConnection.toAddress("");
    connection.input?.listen((event) {
      print(event);
    });
  }
}
