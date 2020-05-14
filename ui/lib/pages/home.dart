import 'package:flutter/material.dart';
import 'package:ui/main.dart';


void main()
{
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Home"),
        backgroundColor: Colors.orangeAccent[700],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child:Column(
        children: <Widget>[
          Text("data"),
          
        ],),
        ),
    
    );
  }
}