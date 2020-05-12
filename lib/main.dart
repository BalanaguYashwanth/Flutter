import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:sms/sms.dart';
import 'bt-controller.dart';
import 'package:bluetooth/services.dart';
//import 'package:flutter_blue/flutter_blue.dart';
  

void main()
{
  runApp(
    MaterialApp(
      home:Tooth(),
    ),
    );
}

class Tooth extends StatefulWidget {
  Tooth({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ToothState createState() => _ToothState();
}
class _ToothState extends State<Tooth> {

   String sensorValue = "N/A";
  

  Future<Null> sendSms()  async {
    SmsSender smsSender = new SmsSender();
    smsSender.sendSms(new SmsMessage('+918610338031', 'your mobile😂')); //instead xxx... to receiver phone
  }

   // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;  
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
List<BluetoothDevice> _devicesList = [];

Future<void> getPairedDevices() async {
  List<BluetoothDevice> devices = [];

  // To get the list of paired devices
  try {
    devices = await _bluetooth.getBondedDevices();
    
  } on PlatformException {
    print("Error");
  }

  // It is an error to call [setState] unless [mounted] is true.
  if (!mounted) {
    return;
  }

  // Store the [devices] list in the [_devicesList] for accessing
  // the list outside this class
  setState(() {
    _devicesList = devices;
    
    print("getting.......");
    
    if(_devicesList.isEmpty)
      {
        name="none";
      }
      else 
      {
        _devicesList.forEach((device) {
          name=device.name;
          //serve get= serve(device:device);
          //get.data();
          //print(get.device1);
         });
      }
  });
}

// void collect(get) async
// {
//   await Future.delayed(Duration(seconds: 4));
//   await get.data;
//   print(get.device.name);
//   await print(get.value1);
//   print("done the service part");
// }

  void connect() async
  {
    print("connected");
    await enableBluetooth();
    await Future.delayed(Duration(seconds:4));
    getPairedDevices();
    BTController.init(onData);
    scanDevices();
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

  Future<void> disconnect() async
  {
    print("disconnected");
    await disableBluetooth();
    //await Future.delayed(Duration(seconds:3));
     getPairedDevices();
  }

  Future<void> disableBluetooth() async {
  _bluetoothState = await FlutterBluetoothSerial.instance.state;
   if (_bluetoothState == BluetoothState.STATE_ON) {
    await FlutterBluetoothSerial.instance.requestDisable();
    return true;
  } 
  return false;
}

String name;


  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings("icon");
    var initializationSettingsIos = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(initializationSettingsAndroid,initializationSettingsIos);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification);

    BTController.init(onData);
    scanDevices();

  }
  
    Future<void> scanDevices() async {

        BTController.enumerateDevices()
            .then((devices) { onGetDevices(devices); });
    }

    void onGetDevices(List<dynamic> devices) {

        Iterable<SimpleDialogOption> options = devices.map((device) {

            return SimpleDialogOption(
                child: Text(device.keys.first),
                onPressed: () { selectDevice(device.values.first); },
            );
        });

        SimpleDialog dialog = SimpleDialog(
            title: const Text('Choose a device'),
            children: options.toList(),
        );

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) { return dialog; }
        );
    }

    selectDevice(String deviceAddress) {

        Navigator.of(context, rootNavigator: true).pop('dialog');
        BTController.connect(deviceAddress);
    }
  
  void onData(dynamic str) { setState(() { sensorValue = str; }); }

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
          Padding(
            padding: EdgeInsets.all(8.0),
            child:Row(
              children:<Widget>[
                RaisedButton.icon(
                  icon:Icon(Icons.sms),
                  onPressed:(){
                   sendSms();
                  },
                  label:Text("SMS"),
                  ),
              ],
            ),
            ),
            Text("BluetoothName-$name"),
            Text('Sensor or Bluetooth Value below'),
            Text(sensorValue),
          ],
        ),
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
         print("result:Notification came ");
  }

}




