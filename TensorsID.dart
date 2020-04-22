import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    home:App(),
  ),);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Tensors ID"),
        centerTitle: true,
      ),
      body:Padding(
        padding:EdgeInsets.all(30),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
         Center(
           child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/nature.jpg'),
            radius: 75,
            
          ),
         ),
          SizedBox(height:20),
          Text("Name"),
          Container(
            child:Text(
              "Ayan",
              style:TextStyle(
                fontSize: 20,
                fontWeight:FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.red, 
               )
              ),
          ),
          SizedBox(height:10),
          Text("Position"),
           SizedBox(height:5),
          Container(
            child:Text(
              "Team Leader",
              style:TextStyle(
                fontSize: 20,
                fontWeight:FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.red, 
               )
              ),
          ),
          SizedBox(height:10),
          Container(
            child:Text("Status"),
          ),
          SizedBox(height:5),
          Text(
            'Doing Project',
            style:TextStyle(
              fontSize: 20,
                fontWeight:FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.red, 

            ),
            ),
            SizedBox(height:10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
              child:Icon(
                Icons.email,
              ), 
              
            ),
            SizedBox(width:5),
            Text("ayan@tensors.com"),
          ], 
          ),
        ],
      ),
      ),

    );
  }
}
