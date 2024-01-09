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
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  bool _isDiscovering = false;
  final List<BluetoothDiscoveryResult> _otherDeviceList = List<BluetoothDiscoveryResult>.empty(growable: true);
  final List<BluetoothDiscoveryResult> _bondedDeviceList = List<BluetoothDiscoveryResult>.empty(growable: true) ;
  final List<BluetoothDiscoveryResult> _connectedDeviceList = List<BluetoothDiscoveryResult>.empty(growable: true);
  // Timer? _discoverableTimeoutTimer;
  // int _discoverableTimeoutSecondsLeft = 0;
  // bool _autoAcceptPairingRequests = true;

  BluetoothState get bluetoothState => _bluetoothState;
  String get address => _address;
  String get name => _name;
  StreamSubscription<BluetoothDiscoveryResult>? get bluetoothStream => _streamSubscription;
  bool get isDiscovering => _isDiscovering;
  List<BluetoothDiscoveryResult> get otherDeviceList => _otherDeviceList;
  List<BluetoothDiscoveryResult> get bondedDeviceList => _bondedDeviceList;
  List<BluetoothDiscoveryResult> get connectedDeviceList => _connectedDeviceList;

  void initBluetoothService(){
    FlutterBluetoothSerial.instance.state.then((value) {
      print(value);
      _bluetoothState = value;
      _openAllScan(value);
      notifyListeners();
    });
    FlutterBluetoothSerial.instance.onStateChanged().listen((event) {
      _bluetoothState = event;
      _getAddress();
      _getName();
      _openAllScan(event);
      print(event);
      notifyListeners();
    });
  }

  void _openAllScan(BluetoothState state){
    if(state == BluetoothState.STATE_ON){
      discoverOtherDevice();
    }
  }

  void _getAddress(){
    FlutterBluetoothSerial.instance.address.then((value){
      _address = value ?? "";
      print("address $value");
      notifyListeners();
    });
  }

  void _getName(){
    FlutterBluetoothSerial.instance.name.then((value){
      _name = value ?? "";
      print("name $value");
      notifyListeners();
    });
  }

  // void connectBluetooth()async{
  //   BluetoothConnection connection = await BluetoothConnection.toAddress("");
  //   connection.input?.listen((event) {
  //     print(event);
  //   });
  // }

  Future<bool?> openBluetooth() => FlutterBluetoothSerial.instance.requestEnable();

  Future<bool?> closeBluetooth() => FlutterBluetoothSerial.instance.requestDisable();

  Future<void> openSetting() => FlutterBluetoothSerial.instance.openSettings();

  Future<int?> requestVisibility(int seconds)async => await FlutterBluetoothSerial.instance.requestDiscoverable(seconds);

  @protected
  void _checkOtherDevices(BluetoothDiscoveryResult result){
    final int existIndex = _otherDeviceList.indexWhere((element) => element.device.address == result.device.address);
    if(existIndex < 0){
      _otherDeviceList.add(result);
    }else{
      _otherDeviceList[existIndex] = result;
    }
  }

  @protected
  void _checkBondedDevices(BluetoothDiscoveryResult result){
    if(result.device.isBonded){
      final int bondedIndex = _bondedDeviceList.indexWhere((element) => element.device.address == result.device.address);
      if(bondedIndex < 0){
        _bondedDeviceList.add(result);
      }else{
        _bondedDeviceList[bondedIndex] = result;
      }
    }
  }

  @protected
  void _checkConnectedDevices(BluetoothDiscoveryResult result){
    if(result.device.isConnected){
      final int connectedIndex = _connectedDeviceList.indexWhere((element) => element.device.address == result.device.address);
      if(connectedIndex < 0){
        _connectedDeviceList.add(result);
      }else{
        _connectedDeviceList[connectedIndex] = result;
      }
    }
  }

  void discoverOtherDevice(){
    _otherDeviceList.clear();
    _bondedDeviceList.clear();
    _connectedDeviceList.clear();
    _streamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((event) {
      print(event);
      _checkOtherDevices(event);
      _checkBondedDevices(event);
      _checkConnectedDevices(event);
      notifyListeners();
    });
    _streamSubscription?.onDone(() {
      _isDiscovering = false;
      print("on done");
      notifyListeners();
    });

    _streamSubscription?.onError((obj, stackTrace){
      _isDiscovering = false;
      print("on error");
      print(obj);
      print(stackTrace);
      notifyListeners();
    });
  }

  void cancelDiscoverStream(){
    _streamSubscription?.cancel();
  }

  Future<void> bondToDevice(BluetoothDiscoveryResult result)async{
    bool? value = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(
      result.device.address,
    );

    print("connection status $value");
    if(value == true){
      _checkBondedDevices(result);
      notifyListeners();
    }
    discoverOtherDevice();
  }

  Future<void> connectDevice(BluetoothDiscoveryResult result)async{
    BluetoothConnection connection = await BluetoothConnection.toAddress(result.device.address,type: ConnectionType.AUTO);
    if(connection.isConnected){
      _checkConnectedDevices(result);
      notifyListeners();
    }
    discoverOtherDevice();
    connection.input?.listen((event) {
      print(event);
    });

  }
}
