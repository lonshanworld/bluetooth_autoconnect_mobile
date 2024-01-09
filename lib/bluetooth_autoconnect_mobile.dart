library bluetooth_autoconnect_mobile;

import 'dart:async';
// "02:3F:68:29:A4:01"
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';


class BluetoothAutoconnectMobile{
  // Future<String?> getPlatformVersion() {
  //   return BluetoothAutoconnectMobilePlatform.instance.getPlatformVersion();
  // }

  BluetoothAutoconnectMobile._();
  static final BluetoothAutoconnectMobile _instance = BluetoothAutoconnectMobile._();
  factory BluetoothAutoconnectMobile() => _instance;

  // Future<BluetoothState> get bluetoothState => FlutterBluetoothSerial.instance.state;

  String? _autoConnectAddress;
  String? get autoConnectAddress => _autoConnectAddress;
  set setAutoConnectAddress(String value) => _autoConnectAddress = value;

  Future<List<BluetoothDevice>>bondedDeviceList = FlutterBluetoothSerial.instance.getBondedDevices();
  Future<bool> bondToDevice(BluetoothDevice device)async{
    bool? value = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(device.address);
    if(value == true) return true;
    return false;
  }

  BluetoothDevice? _currentBluetoothDevice;
  BluetoothDevice? get currentBluetoothDevice => _currentBluetoothDevice;

  Future<int?> requestVisibility()async => await FlutterBluetoothSerial.instance.requestDiscoverable(80);
  Stream<BluetoothDiscoveryResult> get startDiscovery => FlutterBluetoothSerial.instance.startDiscovery();

  Stream<BluetoothState> get streamBluetoothState => FlutterBluetoothSerial.instance.onStateChanged();

  Future<bool> _openBluetooth()async{
    bool? value = await FlutterBluetoothSerial.instance.requestEnable();
    if(value == true)return true;
    return false;
  }

  Future<bool?> get closeBluetooth => FlutterBluetoothSerial.instance.requestDisable();
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;


  Future<bool> requestPermissons()async{
    print("value of want to connect device $_autoConnectAddress");
    if(_autoConnectAddress != null && _autoConnectAddress != ""){
      BluetoothState state = await  FlutterBluetoothSerial.instance.state;
      switch(state) {
        case BluetoothState.STATE_ON :
          return true;
          // await _scanAndConnect(_autoConnectAddress!);
          // break;
        case BluetoothState.STATE_BLE_ON :
          return true;
          // await _scanAndConnect(_autoConnectAddress!);
          // break;
        default :
          return await _openBluetooth();
          // if (value) await _scanAndConnect(_autoConnectAddress!);
          // break;
      }
    }else{
      return false;
    }
  }

  // Future<void> _processStream()async{
  //   _results.clear();
  //   startDiscovery.listen((event) {
  //     final int discoveryIndex = _results.indexWhere((element) => element.device.address == event.device.address);
  //     if(discoveryIndex < 0){
  //       _results.add(event);
  //     }else{
  //       _results[discoveryIndex] = event;
  //     }
  //   });
  //   await startDiscovery.drain();
  // }

  void scanAndConnect(String address)async{

    _streamSubscription = startDiscovery.listen((event) async {
      // final int discoveryIndex = _results.indexWhere((element) => element.device.address == event.device.address);
      // if(discoveryIndex < 0){
      //   _results.add(event);
      // }else{
      //   _results[discoveryIndex] = event;
      // }
      if(event.device.address == address){
        _streamSubscription?.cancel();
        if(event.device.isBonded == true) {
          await connectDevice(address);
        }else{
          bool value = await bondToDevice(event.device);
          if(value) return await connectDevice(address);
        }
      }
    });
    // for (var element in _results) {
    //   if(element.device.address == address){
    //     if(element.device.isBonded == true) {
    //       return await connectDevice(address);
    //     }else{
    //       bool value = await bondToDevice(element.device);
    //       if(value) return await connectDevice(address);
    //     }
    //     break;
    //   }
    // }
  }

  Future<void>connectDevice(String address)async{
    await BluetoothConnection.toAddressBLE(address);
  }
}
