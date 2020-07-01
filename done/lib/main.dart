import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart' as blue;

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

  final blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
  dynamic thing;
  @override
  void initState() {
    super.initState();
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<blue.BluetoothDevice> devices) {
      for (blue.BluetoothDevice device in devices) {
        print(device);
      }
    });
    flutterBlue.scanResults.listen((List<blue.ScanResult> results) {
      for (blue.ScanResult result in results) {
        print(result.device);
        setState(() {
          thing=result.device;
          });
      }
    });
    flutterBlue.startScan();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Myapp"),
      ),

      body:Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("data"),
            Text(thing),
          ],
          ),
        ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},

        ),
      
    );
  }
}