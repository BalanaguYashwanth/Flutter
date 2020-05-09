import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  
   
  void connect() async
  {
    print("connected");
    
    enableBluetooth();
    
  }
  Future<void> enableBluetooth() async {
  _bluetoothState = await FlutterBluetoothSerial.instance.state;
  if (_bluetoothState == BluetoothState.STATE_OFF) {
    await FlutterBluetoothSerial.instance.requestEnable(); //To enable bluetooth in our device
    showNotification();
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
  _bluetoothState = await FlutterBluetoothSerial.instance.state;
   if (_bluetoothState == BluetoothState.STATE_ON) {
    await FlutterBluetoothSerial.instance.requestDisable();
    return true;
  } 
  return false;
}


  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings("icon");
    var initializationSettingsIos = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(initializationSettingsAndroid,initializationSettingsIos);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification);
  }
   

  Future onSelectNotification(String payload) {

    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
   
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon:Icon(
                  Icons.settings,
                  color:Colors.white),
                onPressed: (){
                   FlutterBluetoothSerial.instance.openSettings();
                },
                color: Colors.blue,
                label:Text("Bluetooth settings",
                style:TextStyle(color: Colors.white,)),
                )
          ],
          ),
          ),
          ],
        )
      ),
    ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max,
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    //await Future.delayed(Duration(seconds:3));
    await  flutterLocalNotificationsPlugin.show(
        0, 'Bluetooth', 'Requesting to ON', platform,
         payload: 'Bluetooth is requesting to on in your device ');
         print("result");
  }


}





