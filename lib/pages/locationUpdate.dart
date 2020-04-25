
import 'package:flutter/material.dart';
import 'package:world_time/services/world.dart';

void main()
{
  runApp(
    MaterialApp(
      home:Update(),

    ),
  );
}

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}


class _UpdateState extends State<Update> {
  
  List<World> sample=[

  World(name:'london',icon:'lodon',url:'Europe/London'),
  World(name:'America',icon:'America',url:'America/Adak'),
  World(name:'Bangkok',icon:'lodon',url:'Asia/Bangkok'),
  World(name:'Dubai',icon:'lodon',url:'Asia/Dubai'),

];

void update(index) async
{
  World instance = sample[index];
  await instance.getdata();

   Navigator.pop(context,{
    'data1':instance.data1,
    'data2':instance.data2,
    'isday1':instance.isday,

  });

}

  @override
  Widget build(BuildContext context) {
    print("Build content");
    return Scaffold(
      appBar:AppBar(
        title:Text('locationUpdate'),
        backgroundColor: Colors.blue[200],
      ),
      body:RaisedButton(
        onPressed:(){
          
        },
      child:ListView.builder(
        itemCount: sample.length,
        itemBuilder:(context,index)
        {
          return Card(
            child:ListTile(
              onTap: (){
                update(index);
              },
              title:Text(sample[index].name),
          ),
          );
        }
      )
      )

      );
  }
}