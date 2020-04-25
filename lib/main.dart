

import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/locationUpdate.dart';


void main()
{
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes:{
        '/home':(context)=>Home(),
        '/'     :(context)=>Loading(),
        '/update':(context)=>Update(),
      }

    ),
  );
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      
    );
  }
}