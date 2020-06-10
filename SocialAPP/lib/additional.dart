
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart' as blue;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import './main.dart';


void main()
{
  runApp(MaterialApp(
    home: Addition(),
  ));
}

 
class Addition extends StatefulWidget {
  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instruction to follow",
         style: TextStyle(
               color: Colors.white,
             ),),
        backgroundColor: Colors.orangeAccent[700],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            ),

            Customize('1) *Dont press the Refresh button more than 3 times'),
            Text("    * = Note:Pressig more than 3 times the refresh button your"),
            Text("    operating system may damage"),
            
            Customize('2) If you found any error after opening the app please close&open the app again '),
            Customize('3) If you found the data is not updating after clicking refresh button several times please close&open the app again'),
            Customize('4) when you are using the this app it should be in the recent apps in your device'),
            Customize("5) Any complaints and improvements regarding this app please send mail to sathyabama@gmail.com"),
            Customize('6) If you follow these steps you can use the app in sustainable way'),
            SizedBox(height: 20,),
            Center(
              child: Text('Your reponse matters....',
              style: TextStyle(
                letterSpacing: 2.0,
               fontWeight: FontWeight.bold,
               fontStyle: FontStyle.italic,
               //color: Colors.orangeAccent[800],
              ),),
            ),

            
        ],
        
        
      ),
      

      
    );
    
  }
}

class Customize extends StatelessWidget {
  String text;
  Customize(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
              child:  Text(
                      text,
                       textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                    style: TextStyle(
                     
                    ),
                    ),
      ),
              ],
            ),

      );
  }
}

