import 'package:flutter/material.dart';
import './pages/settings.dart';
import './pages/home.dart';

void main()
{
    runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
      routes:{
        '/settings':(context)=> Settings(),
        '/home':(context)=>Home(),
      },
    theme: ThemeData(
      brightness:Brightness.light,
      ),
    home:Ui(),
  ));
}

class Ui extends StatefulWidget {
  @override
  _UiState createState() => _UiState();
}

class _UiState extends State<Ui> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        backgroundColor: Colors.orangeAccent[700],
      ),
      drawer:MainDrawer(),
    );
  }
}


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
               child:ListView(
                children: <Widget>[
                DrawerHeader(
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                      colors:<Color>[
                      Colors.deepOrange,
                      Colors.orangeAccent,
                      ],
                     ),
                 ),
                 child:Container(
                   child:Column(
                     children: <Widget>[
                       Icon(Icons.account_circle,
                       size: 120,),
                       Text("Mavic dots",
                       style: TextStyle(
                         letterSpacing:4.5,
                         fontWeight: FontWeight.bold,
                         ),
                         ),
                     ],
                   ),
                 ),
                 ),
                 Cutomize(Icons.info,'info',(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,'/settings');
                  }),
                ],
              ),
      );
  }
}

class Cutomize extends StatelessWidget {
  IconData icon;
  String text;
  Function ontap;
  Cutomize(this.icon,this.text,this.ontap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child:InkWell(
        onTap:ontap,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
            children: <Widget>[
            Icon(Icons.info),
            SizedBox(width:10),
            Text(text,
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
            ],),
            Icon(Icons.arrow_right),
        ],
        ),
      ),
    );
  }
}