
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class Flutter2NativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter2NativePage"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("无参"),
            onPressed: () {
              // Flutter 跳转 Native (无参)
              FlutterBoost.singleton.open('sample://nativePage');
            },
          ),
          RaisedButton(
            child: Text("有参"),
            onPressed: () {
              // Flutter 跳转 Native (有参)
              FlutterBoost.singleton.open('sample://nativePage', urlParams: {'params': 'flutter2native'});
            },
          ),
          RaisedButton(
            child: Text("有参 + 返回值"),
            onPressed: () {
              // Flutter 跳转 Native (有参 + 返回值)
              FlutterBoost.singleton.open('sample://nativePage', urlParams: {'params': 'flutter2native'}).then((Map value) {
                print('value = $value');
              });
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
