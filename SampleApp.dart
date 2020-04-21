import 'package:flutter/material.dart';


void main()
{
  runApp(MaterialApp(
    home:Home(),
  ),);

}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Tensors"),
        leading: Icon(Icons.accessibility),
        actions: <Widget>[
          Center(
           child:Icon(Icons.access_time) 
          ), 
        ],
        centerTitle: true,
        backgroundColor:Colors.red[500],
      ),
      body:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         
          Expanded(
            flex:1,
          child:Container( 
            child:Text("1"),
            color:Colors.amber,
            padding: EdgeInsets.all(30),
          ),
          ),
          
          Expanded(
            flex: 1,
          child:Image.asset('assets/images/nature.jpg'),
          ),
          Expanded(
            flex:1,
          child:Container(
            child:Text("2"),
            color:Colors.greenAccent,
            padding: EdgeInsets.all(30),
          ),
          ),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {},
        child: Text("kick it"),
        backgroundColor: Colors.red,
      ),
    );
  }
}




