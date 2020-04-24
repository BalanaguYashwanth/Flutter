import 'package:http/http.dart';
import 'dart:convert';

class World{

  String url;
  String data1;
  String data2;
  String time; 

  World({this.url});

  

  Future<void> getdata()  async{
  
  try{

   Response response = await get("http://worldtimeapi.org/api/timezones/$url");
   Map data = jsonDecode(response.body);
   data2=data['utc_offset'].substring(1,6);
   data2=data2.toString();
   data1=data['datetime'].toString();
    }catch(e)
    {
      print('THE ERROR IS $e');
      data1='not able to predict';
      data2='not able to predict';
    
    }

  
}
}
