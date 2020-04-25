import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world.dart';

void main()
{
  runApp(
    MaterialApp(
      home:Loading(),
    )
  );
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  String show="loading"; 
  String show1="loading112";


  void setup() async
  {
    World collect = World(url:'/Asia/Kolkata',icon:'state.png');
    await collect.getdata();

    Navigator.pushReplacementNamed(context,'/home',arguments: {

    'show':collect.data1,
    'show2':collect.data2,
    'icon':collect.icon,
    'isday':collect.isday,

    });
  }
   
  
  @override
  void initState() {
    
    super.initState();
    setup();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding:EdgeInsets.all(50),
        child:Center(
          child: SpinKitCircle(
              color: Colors.red,
              size: 100.0,
              ),
        ),
      ),
    );
  }
}