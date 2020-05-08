import 'package:flutter/material.dart';


 import 'dart:async';
 import 'dart:convert';


 import 'package:flutter/services.dart';
 

 import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main()
{
  runApp(
    MaterialApp(
      home:Tooth(),

    ),
    );
}

class Tooth extends StatefulWidget {
  @override
  _ToothState createState() => _ToothState();
}

class _ToothState extends State<Tooth> {

   // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    
  }
   
  void connect()
  {
    print("connected");
    enableBluetooth();

   
  }

    Future<void> enableBluetooth() async {
  // Retrieving the current Bluetooth state
  _bluetoothState = await FlutterBluetoothSerial.instance.state;
 
  // If the Bluetooth is off, then turn it on first
  // and then retrieve the devices that are paired.
  if (_bluetoothState == BluetoothState.STATE_OFF) {
    await FlutterBluetoothSerial.instance.requestEnable(); //To enable bluetooth in our device
    return true;
  } 
  return false;
}

  void disconnect()
  {
    print("disconnected");
    disableBluetooth(); 
  }

  Future<void> disableBluetooth() async {
  // Retrieving the current Bluetooth state
  _bluetoothState = await FlutterBluetoothSerial.instance.state;
 
  // If the Bluetooth is off, then turn it on first
  // and then retrieve the devices that are paired.
  if (_bluetoothState == BluetoothState.STATE_ON) {
    await FlutterBluetoothSerial.instance.requestDisable();
    getPairedDevices();
    return true;
  } 
  return false;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("BluetoothApp"),
      ),
      body:SafeArea(

      child:Container(
        child:Column(
          children: <Widget>[

          Padding(
            padding: EdgeInsets.all(8.0),

        child:Row(
          mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child:RaisedButton.icon(
            onPressed:(){
              connect();
            },
            icon:Icon(Icons.bluetooth_connected),
            label:Text(" connected"),
          ),
          ),
          Container(
            child:RaisedButton.icon(
            onPressed:(){
              disconnect();
            },
            icon:Icon(Icons.bluetooth_disabled),
            label:Text(" disconnected"),
          ),
          margin:EdgeInsets.fromLTRB(40, 10, 10, 0),
          ),
        ],
        ),
          ),
          ],
        )
      ),
    ),
    );
  }
}


