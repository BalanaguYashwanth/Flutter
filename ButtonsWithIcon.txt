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
        child:RaisedButton.icon(
          onPressed:(){
            print("done");
          },
          label:Text("comment me"),
          icon:Icon(
            Icons.add_comment
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




