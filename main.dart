import 'package:flutter/material.dart';
import 'package:flashlight/flashlight.dart';


void main()
{
  runApp(
    MaterialApp(
      home: Logic()
    ),
  );
}

class Logic extends StatefulWidget {

  @override
  _LogicState createState() => _LogicState();
}

class _LogicState extends State<Logic> {
  //int i=1;
  //String content="Counting the pressed times";
  String content="off";

  @override
  void initState() {
    super.initState();
    flash();
  }

  void flash() async
  {
    bool hasFlash= await Flashlight.hasFlashlight;
    }
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
        appBar: AppBar(
          title: Text("Flash app 👏👏😊"),
        ),
        body: 
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 300, 0, 0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                Text("Status:flash is $content"),
                RaisedButton.icon(
                  onPressed: (){
                    Flashlight.lightOn();
                    setState(() {
                      content="on";
                    });
                  },
                  icon: Icon(Icons.flash_on),
                  label: Text("flashOn"),
                  ),
                RaisedButton.icon(
                  onPressed: (){
                    Flashlight.lightOff();
                    setState(() {
                      content="off";
                    });
                  },
                  icon: Icon(Icons.flash_off),
                  label: Text("flashOff"),
                  )

         ],
         ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child:Icon(Icons.add),
        ),
      );
  }
}