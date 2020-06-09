import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart' as blue;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:safety/additional.dart';

void main()
{
  runApp(MaterialApp(
    home:Tooth(),
  ));
}


class Tooth extends StatefulWidget {
  @override
  _ToothState createState() => _ToothState();
}

class _ToothState extends State<Tooth> {
   

  String refresh="";

  final blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
  final List<dynamic> devicesList = new List<dynamic>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    StreamSubscription _bluetoothScanSubscription;
    var _connectedDevice;

  _addDeviceTolist(final dynamic device) {
     if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
     }
  }


  @override
  void initState() {
   
    super.initState();
    //int result1;
    startServicePlatform();

    var initializationSettingsAndroid = new AndroidInitializationSettings("app_icon");
    var initializationSettingsIos = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(initializationSettingsAndroid,initializationSettingsIos);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification); 

    blue.FlutterBlue.instance.state.listen((state) {
          if (state == blue.BluetoothState.off) {
            _showDialog();

        } else if (state == blue.BluetoothState.on) {
              btn(); 
            }
        });



  }


// user defined function
 void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ALERT"),
          content: new Text(" Please on bluetooth "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

    Future<dynamic> btn() async{
      
     
     setState(() {
       refresh="";
     });
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<blue.BluetoothDevice> devices) {
      for (blue.BluetoothDevice device in devices) {
        print(device);
        _addDeviceTolist(device);
      }
    });

      
      flutterBlue.scanResults.listen((List<dynamic> results) async {
       
      for (dynamic result in results)  {

         print("start");
        

         await Future.delayed(Duration(seconds:5));
          _addDeviceTolist(result);

         print(result.device.name);
         print(result.rssi);
          _connectedDevice = result.device.name;

           if(result.rssi<=-80)
           {
             await Future.delayed(Duration(seconds:2));
             await showNotification();
           }
         
         print("done");
      }
    });
    flutterBlue.startScan();
    } 

  

   Widget _buildListViewOfDevices() {
    List<Container> containers = new List<Container>();
    
    for (dynamic result in devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Column(
           mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("$refresh"),
              Expanded(
                child: Row( 
                  
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[  
                    
                   Text("DeviceName:"),
                    Text(result.device.name == '' ? '(unknown bluetooth device)' : result.device.name),
                    
                    Text("  Rssi value  "),
                    Text(result.rssi.toString()),
                   // Text(result.device.id.toString()),

         
                  ],

                  
                ),
                
              
              ),
              
             
            ],
            
                      
          ),
          
        
        ),
      );
    }
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,
     ],
   );
    
   }
   
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
        debugPrint("resume");
    } else if (state == AppLifecycleState.paused) {
       debugPrint("pause");
    }
  }


  void startServicePlatform() async{
    if(Platform.isAndroid){
      var methodChannel=MethodChannel("com.example.safety");
      String data =await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title:Text("Social Distancing App"),
       
      ),
    
      body:SafeArea(
              child:Container(
                decoration:new BoxDecoration(
                    //color: const Color(0xff7c94b6),
                    color: Colors.white,
                  image:DecorationImage(
                    image:AssetImage('assets/download.jpeg'), 
                    fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
                  ),
                ),
                child: _buildView(),
              )
      ),
      
      floatingActionButton: Container(
        height: 60,
        width: 60,
      child:FloatingActionButton(
        onPressed: () async{
           
          setState(() {
            refresh="refershing.. please wait.....";
          });
          await Future.delayed(Duration(seconds:3));
           btn();
        },
        child:Text(
          'Refresh',
          style: TextStyle(
            fontSize: 13,
            color: Colors.red,
            backgroundColor:Colors.white, 

          ),),

        ),
        
    ),
  
    );
  }


  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildListViewOfDevices();
    }
    return _buildListViewOfDevices();
  }



  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',sound: RawResourceAndroidNotificationSound('alert'),
        priority: Priority.High,importance: Importance.Max,
    );
    
    var iOS = new IOSNotificationDetails(sound: "alert.aiff");
    var platform = new NotificationDetails(android, iOS);
    await  flutterLocalNotificationsPlugin.show(
        0, 'Safety app', 'Requesting to maintain social distance', platform,
         payload: 'Please maintain the social distance ');
         print("result:Notification came ");
  }

}
