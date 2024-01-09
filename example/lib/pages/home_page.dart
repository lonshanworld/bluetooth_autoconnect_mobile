import 'package:bluetooth_autoconnect_mobile/bluetooth_autoconnect_mobile.dart';
import 'package:bluetooth_autoconnect_mobile_example/widgets/bluetooth_result_box.dart';
import 'package:bluetooth_autoconnect_mobile_example/widgets/cus_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BluetoothAutoconnectMobile bluetoothAutoconnectMobile = BluetoothAutoconnectMobile();

  @override
  void initState(){
    super.initState();
    bluetoothAutoconnectMobile.setAutoConnectAddress = "02:3F:68:29:A4:01";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      startConnect();
    });
  }

  void startConnect()async{
    bool value = await bluetoothAutoconnectMobile.requestPermissons();
    if(value){
      bluetoothAutoconnectMobile.scanAndConnect("02:3F:68:29:A4:01");
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bluetooth autoconnect testing app",
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.maxFinite,
            child: Row(
              children: [
                CusBtn(
                  "discover other device",
                  () {
                    // o
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
