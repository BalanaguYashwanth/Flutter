import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLE Demo',
      home: MyHomePage(title: 'Flutter BLE Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BleManager _bleManager = BleManager(); 
  bool _isScanning= false;               
  List<BleDeviceItem> deviceList = [];   
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int count=0;
  int limit=0;
  var devices=List();


  @override
  void initState() {
    init(); 
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings("app_icon");
    var initializationSettingsIos = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(initializationSettingsAndroid,initializationSettingsIos);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification); 



  }



  void init() async {

      
      await _bleManager.createClient(
        restoreStateIdentifier: "example-restore-state-identifier",
        restoreStateAction: (peripherals) {
          peripherals?.forEach((peripheral) {
            print("Restored peripheral: ${peripheral.name}");
          });
        })
        .catchError((e) => print("Couldn't create BLE client  $e"))
        .then((_) => _checkPermissions()) 
        .catchError((e) => print("Permission check error $e"));
        //.then((_) => _waitForBluetoothPoweredOn())        

        scan();
  }
  
  _checkPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.contacts.request().isGranted) {        
      }
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location
      ].request();
      print(statuses[Permission.location]);
         
    }
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

  // ON/OFF 
  void scan() async {
    limit=0;
    if(!_isScanning) {
      deviceList.clear();
      print("deviceList1");
      
      _bleManager.startPeripheralScan().listen((scanResult) {          
        var name = scanResult.peripheral.name ?? scanResult.advertisementData.localName ?? "Unknown";
        print(name);
        /*
        print("Scanned Name ${name}, RSSI ${scanResult.rssi}");        
        print("\tidentifier(mac) ${scanResult.peripheral.identifier}"); //mac address
        print("\tservice UUID : ${scanResult.advertisementData.serviceUuids}");        
        print("\tmanufacture Data : ${scanResult.advertisementData.manufacturerData}");        
        print("\tTx Power Level : ${scanResult.advertisementData.txPowerLevel}");
        print("\t${scanResult.peripheral}");
        */ 
        
        var findDevice = deviceList.any((element) {        
                
          if(element.peripheral.identifier == scanResult.peripheral.identifier)
          {
            
            element.peripheral = scanResult.peripheral;
            element.advertisementData = scanResult.advertisementData;            
            element.rssi = scanResult.rssi;
            if(element.rssi <-80)
            {
              if(!devices.contains(element.peripheral))
              {
                devices.add(element.peripheral);
                count=count+1;
                
                print(limit);
                if(count<2)
                {
                  limit=limit+1;
                  if(limit<5)
                  {
                    showNotification();

                  }
                }  
              }

            }

            return true;            
          }        
          return false;
        });
        
        if(!findDevice) {
          count=0;
          deviceList.add(BleDeviceItem(name, scanResult.rssi, scanResult.peripheral, scanResult.advertisementData));
        }
      
        setState((){});
      });      
      
      setState(() { _isScanning = true; });
    }
    else {      
      print("stop");
      _bleManager.stopPeripheralScan();      
      setState(() { _isScanning = false; });
    }
  }
  
  
  list() {
    return ListView.builder( 
      itemCount: deviceList.length, 
      itemBuilder: (context, index) { 
        return ListTile( 
          title: Text(deviceList[index].deviceName), 
          subtitle: Text(deviceList[index].peripheral.identifier),
          trailing: Text("${deviceList[index].rssi}"),          
        ); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  list(),
      
       floatingActionButton: FloatingActionButton(
         onPressed: scan,        
        
         child: Icon(_isScanning?Icons.stop:Icons.bluetooth_searching), 
        
       ),
    );
  }


   Future showNotification() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound: RawResourceAndroidNotificationSound('alert'),
      importance: Importance.Max,
      priority: Priority.High);
  var iOSPlatformChannelSpecifics =
      new IOSNotificationDetails(sound: "alert.aiff");
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Safety app',
    'Requesting to maintain social distance',
    platformChannelSpecifics,
    payload: 'Please maintain the social distance',
  );
    print("result:Notification came ");
}

}


class BleDeviceItem {
    String deviceName;
    Peripheral peripheral;
    int rssi;
    AdvertisementData advertisementData;   
    BleDeviceItem(this.deviceName, this.rssi, this.peripheral, this.advertisementData);
}
