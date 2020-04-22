import 'package:flutter/material.dart';
import 'quote.dart';

void main()
{
  runApp(MaterialApp(
    home:Customclass(),
  ));
}

class Customclass extends StatefulWidget {
  @override
  _CustomclassState createState() => _CustomclassState();
}

class _CustomclassState extends State<Customclass> {

   List<Quote> quotes=[

    Quote(author:'yash',des:'The man should brave'),
    Quote(author:'yash',des:'That you need you need'),
    Quote(author:'yash',des:'Thankyou you to man you'),
    

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customclass"),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: quotes.map((quote)=>Text('${quote.author}-${quote.des}')).toList())
    );
  }
}
