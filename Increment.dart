import 'package:flutter/material.dart';


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
  dynamic i=1;
  String content="Counting the pressed times";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Main Increment ??????"),
        ),
        body: 
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 300, 0, 0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                //Text(content),
                Text(
                  " $i",
                style:TextStyle(
                  fontWeight:FontWeight.bold,
                  letterSpacing:2.0,
                  color: Colors.amber,
                  fontSize: 30,
                  )
                  ),
         ],
         ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState((){
              i=i+1;
              if(i==15)
              {
                i="Full";
                
              }

            });
          },
          child:Icon(Icons.add)
        ),
      );
  }
}
