import 'package:flutter/material.dart';

void main()
{
  runApp(
    MaterialApp(
      home: Settings(),

    ),
  ); 
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Info"),
        backgroundColor: Colors.orangeAccent[700],
      ),
    );
  }
}