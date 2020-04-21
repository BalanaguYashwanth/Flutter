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
        backgroundColor:Colors.red[500],
      ),
      body: Center(
        child:FlatButton(
          onPressed:(){
            print("done");
          },
          child:RaisedButton.icon(
            onPressed: (){},
            icon:Icon(Icons.ac_unit),
            label:Text("data"),
            color: Colors.red,
            ),
          
          color:Colors.redAccent,
          ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {},
        child: Text("kick it"),
        backgroundColor: Colors.red,
      ),
    );
  }
}




