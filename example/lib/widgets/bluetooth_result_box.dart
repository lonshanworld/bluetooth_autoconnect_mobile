import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:provider/provider.dart';

class BluetoothResultBox extends StatelessWidget {

  final BluetoothDiscoveryResult result;
  final VoidCallback func;
  const BluetoothResultBox(this.result,this.func,{super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.green,
          )
      ),
      child: InkWell(
        onTap:func,
        child: Column(
          children: [
            Text(result.device.name ?? ""),
            Text(result.device.address),
            Text(result.device.bondState.stringValue),
            Text(result.device.type.stringValue),
            Text("connected ${result.device.isConnected}"),
            Text(result.rssi.toString()),
          ],
        ),
      ),
    );
  }
}
