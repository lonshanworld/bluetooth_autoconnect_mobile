import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile.dart';
import 'package:bluetooth_autoconnect_mobile_example/widgets/bluetooth_result_box.dart';
import 'package:bluetooth_autoconnect_mobile_example/widgets/cus_btn.dart';
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(bluetoothAutoconnectMobile.bluetoothState.toString()),
          Text("my device name ${bluetoothAutoconnectMobile.name}"),
          Text("my device address ${bluetoothAutoconnectMobile.address}"),
          CusBtn(
            "open bluetooth",
            () {
              context.read<BluetoothAutoconnectMobile>().openBluetooth();
            },
          ),
          CusBtn(
            "close bluetooth",
                () {
              context.read<BluetoothAutoconnectMobile>().closeBluetooth();
            },
          ),
          CusBtn(
            "open bluetooth setting",
                () {
              context.read<BluetoothAutoconnectMobile>().openSetting();
            },
          ),
          CusBtn(
            "request visibility",
            () {
              context.read<BluetoothAutoconnectMobile>().requestVisibility(60);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.maxFinite,
            child: Row(
              children: [
                CusBtn(
                  "discover other device",
                  () {
                    context.read<BluetoothAutoconnectMobile>().discoverOtherDevice();
                  },
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: bluetoothAutoconnectMobile.otherDeviceList.map((e) => SingleChildScrollView(
                      child: BluetoothResultBox(
                        e,
                        (){
                          context.read<BluetoothAutoconnectMobile>().bondToDevice(e);
                        }
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.maxFinite,
            child: Row(
              children: [
                Text("Bonded Devices"),
                Expanded(
                  child: Row(
                    children: bluetoothAutoconnectMobile.bondedDeviceList.map((e) => SingleChildScrollView(
                      child: BluetoothResultBox(
                        e,
                        (){
                          context.read<BluetoothAutoconnectMobile>().connectDevice(e);
                        }
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.maxFinite,
            child: Row(
              children: [
                Text("Connected Devices"),
                Expanded(
                  child: Row(
                    children: bluetoothAutoconnectMobile.connectedDeviceList.map((e) => SingleChildScrollView(
                      child: BluetoothResultBox(
                          e,
                          (){

                          }
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
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
