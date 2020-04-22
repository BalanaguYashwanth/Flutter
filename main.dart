import 'package:flutter/material.dart';
import 'quote1.dart';
import 'Quotecard.dart';

void main()
{
  runApp(MaterialApp(
    home:Classapp(),    
  ));
}

class Classapp extends StatefulWidget {
  @override
  _ClassappState createState() => _ClassappState();
}
class _ClassappState extends State<Classapp> {
  
  List<Quote> quotes=[
    Quote(author:"Hi there i am there",text: "yash"),
    Quote(author:"Go there you are there",text: "yash"),
    Quote(author:"mover there you are there",text: "yash"),
  ]; 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Customclass"),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:quotes.map((quote)=>Quotecard(
        quote:quote,
        delete:() {
          setState((){
            quotes.remove(quote);
          });
          }        
          )).toList(),

        ),

        
    );
  }
}
