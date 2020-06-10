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
    debugShowCheckedModeBanner: false,
    home:Tooth(),
  // darkTheme: ThemeData(
  //   brightness: Brightness.dark,
  // ),
  ),
  );
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
      
      devicesList.clear();
     
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

    int count=0;

      
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
             count=count+1;
             //await showNotification();
           }

           if(count<3)
           {
              await Future.delayed(Duration(seconds:2));
              await showNotification();
              count=0;
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
                    
                   Text("DeviceName:",
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     letterSpacing: 1.0,
                     color:Colors.black,
                   ),),
                    Text(result.device.name == '' ? '(unknown bluetooth device)' : result.device.name),
                    
                    Text("  Rssi value  ",
                    style: TextStyle(
                     fontWeight: FontWeight.w500,
                     letterSpacing: 1.0,
                     color:Colors.black,
                   ),),
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
        title:Text("Safety App",
        style: TextStyle(
               color: Colors.white,
             ),),
        backgroundColor: Colors.orangeAccent[700],
        actions: <Widget>[
           FlatButton.icon(
             onPressed: (){
               Navigator.push(context, MaterialPageRoute(
                 builder:(BuildContext context)=>Addition())
                 );
             },
             label: Text("Instructions to follow",
             style: TextStyle(
               color: Colors.white,
               fontSize: 16
             ),),
             icon:Icon( Icons.info,
             color: Colors.white,
             ),
             ),
        ],
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
        height: 50,
        width: 100,
        
      child:FloatingActionButton.extended(
         backgroundColor:Colors.orangeAccent[700],
         label: Text("Refresh"),
         icon:Icon(Icons.refresh) ,
        onPressed: () async{
           
          setState(() {
            refresh="refershing.. please wait.....";
          });
          await Future.delayed(Duration(seconds:3));
           btn();
        },
        // child:Text(
        //   'Refresh',
        //   style: TextStyle(
        //     fontSize: 13,
        //     color: Colors.red,
        //     backgroundColor:Colors.white, 

        //   ),),

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



  // showNotification() async {
  //   var android = new AndroidNotificationDetails(
  //       'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',sound: RawResourceAndroidNotificationSound('alert'),
  //       priority: Priority.High,importance: Importance.Max,
  //   );
    
  //   var iOS = new IOSNotificationDetails(sound: "alert.aiff");
  //   var platform = new NotificationDetails(android, iOS);
  //   await  flutterLocalNotificationsPlugin.show(
  //       0, 'Safety app', 'Requesting to maintain social distance', platform,
  //        payload: 'Please maintain the social distance ');
  //        print("result:Notification came ");
  // }


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
