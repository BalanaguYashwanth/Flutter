import 'package:flutter/material.dart';
import 'quote1.dart';

class Quotecard extends StatelessWidget {
  
  final Quote quote;
  final Function delete;
  
  Quotecard({this.quote,this.delete});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      color: Colors.amber,
      margin:EdgeInsets.all(15),
      
      child:Padding(
      padding:EdgeInsets.all(10),  
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
          quote.author,
        style:TextStyle(
          fontSize: 20,
       
          color:Colors.red,
          fontWeight:FontWeight.bold,
          letterSpacing:2.0,
        ),
        ),
        Text(
          quote.text,
        style:TextStyle(
          fontSize: 20,
          
          color:Colors.red,
          fontWeight:FontWeight.bold,
          letterSpacing:2.0,
        ),
        ),
        FlatButton.icon(
          onPressed: delete,
          label: Text('Remove'),
          icon: Icon(Icons.delete),
          ),

      ],)
      ),

    );
  }
}

