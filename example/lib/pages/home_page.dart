import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    final BluetoothAutoconnectMobile bluetoothAutoconnectMobile = context.watch<BluetoothAutoconnectMobile>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bluetooth autoconnect testing app",
        ),
      ),
      body: Column(
        children: [
          Text(bluetoothAutoconnectMobile.bluetoothState.toString()),

        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<BluetoothAutoconnectMobile>().initBluetoothService();
  }
}
