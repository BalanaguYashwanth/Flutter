import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class serve
{
  dynamic device;
  dynamic device1;
  dynamic _services;
  dynamic sub;
  int value1;
  serve({this.device});
  
  Future<void> data() async 
  {
    device1=device.name;
    final FlutterBlue flutterBlue = FlutterBlue.instance;
    final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
    _services = await device.discoverServices();
     for (BluetoothService service in _services) 
     {
      for (BluetoothCharacteristic characteristic in service.characteristics) 
      {
         characteristic.value.listen((value) 
         {
         print(value);
         readValues[characteristic.uuid] = value;
         value1=1;
         });
      }
       service.uuid.toString();
     }
  }
}

