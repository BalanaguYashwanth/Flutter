import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  static const platform = const MethodChannel('bluetooth.channel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Native'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue[500],
              onPressed: () {
                printMethod();
              },
              child: Text('connect to Devices'),
            ),
            RaisedButton(
              color: Colors.blue[500],
              onPressed: () {
                discoverBlue();
              },
              child: Text('Discover devices'),
            ),
            RaisedButton(
              color: Colors.blue[500],
              onPressed: () {
                getAllPaired();
              },
              child: Text('All paired devices'),
            )
          ],
        ),
      ),
    );
  }

  void printMethod() async {
    String value;
    try {
      value = await platform.invokeMethod("getBlue");
    } catch (e) {
      print(e);
    }
    print('printing from dart: $value');
  }

  void discoverBlue() async {
    Future<List> list;
    list = platform.invokeListMethod("discoverBlue", list);
    list.then((val) {
      print("got values from kotlin $val");
    });
  }

  void getAllPaired() async {
    var value = await platform.invokeListMethod("allPaired");
    print(value);
  }
}
