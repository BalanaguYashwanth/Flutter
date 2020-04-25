import 'package:http/http.dart';
import 'dart:convert';

class World{

  String url;
  String data1;
  String data2;
  String time; 
  String icon;
  bool isday;
  String data3;
  int com;
  String name;

  World({this.url,this.icon,this.name});

  Future<void> getdata()  async{
  
  try{

   Response response = await get("http://worldtimeapi.org/api/timezone/$url");
   Map data = jsonDecode(response.body);
   data2=data['datetime'].substring(11,19);
   data2=data2.toString();
   data1=data['datetime'].substring(0,10);
   data1=data1.toString();
   data3=data['datetime'].substring(11,13);
   com=int.parse(data3);
   isday= com > 8 && com < 17 ? true:false;
   print(data1);
   

    }catch(e)
    {
      print('THE ERROR IS $e');
      data1='not able to predict';
      data2='not able to predict';
    
    }

  
}
}