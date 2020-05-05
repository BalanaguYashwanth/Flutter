import 'package:flutter/material.dart';

void main()
{
  runApp(
    MaterialApp(
      home: Logic()
    ),
  );
}

class Logic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Main 👏👏😊"),
        ),
        body: 
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 250, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  onPressed: (){}, 
                  icon: Icon(Icons.access_alarm),
                   label: Text("hi mom"),
                  ),
                Container(
                  child:Text('tile'),
                  margin: EdgeInsets.all(50),
                ), 
              Icon(Icons.ac_unit),
         ],
         ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child:Icon(Icons.ac_unit)
        ),
      );
  }
}
