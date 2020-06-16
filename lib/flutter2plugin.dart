import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const battery = const MethodChannel('samples.flutter.dev/battery');
const battery2 = const MethodChannel('samples.flutter.dev/battery2');

class FlutterPluginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterPluginPage"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _getBatteryLevel,
            child: Text("getBatteryLevel"),
          ),
          RaisedButton(
            onPressed: _getBatteryLevel2,
            child: Text("getBatteryLevel2"),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await battery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    print('_getBatteryLevel $batteryLevel');
  }

  Future<Null> _getBatteryLevel2() async {
    String batteryLevel;
    try {
      final int result = await battery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    print('_getBatteryLevel $batteryLevel');
  }
}
