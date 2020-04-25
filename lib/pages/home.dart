import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    home:Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data: ModalRoute.of(context).settings.arguments;
    String bgimage=data['isday']? 'day.png':'night.png';
    //String bgcolor=data['isday']? 'Colors.grey':'Colors.red';
    return Scaffold(
      body:SafeArea(
              child:Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage('assets/$bgimage'), 
                    fit: BoxFit.cover,
                  ),
                ),

              child:Padding(
                padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
               child:Column(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () async{
                dynamic result=await Navigator.pushNamed(context,'/update');
                  setState((){
                    data={
                   'show':result['data1'],
                   'show2':result['data2'],
                   'isday':result['isday1'],
                   };
                  });
              },
              icon: Icon(
                Icons.location_on,
                color:Colors.red,
                ),
              label:Text(
                "Add loaction",
                style: TextStyle(
                  color: Colors.red,
                ),),
            ),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Text(
                    data['show'],
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 2.0,
                    color: Colors.red,
                    
                  ),

                ),
                SizedBox(width:20),
                Text(
                  data['show2'],
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2.0,
                    color: Colors.red,
                    
                  ),

                )



              ],
            
            ),

          ],
          

        ),
        ),
              ),
      ),
      );
  }
}