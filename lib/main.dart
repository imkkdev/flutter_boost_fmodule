import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/flutter2native.dart';
import 'package:flutter_module/flutter2plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterBoost.singleton.registerPageBuilders({
      '/first': (pageName, params, _) => FirstScreen(),
      '/second': (pageName, params, _) => SecondScreen(args: params),
      '/flutterPlugin': (pageName, params, _) => FlutterPluginPage(),
      '/flutter2native': (pageName, params, _) => Flutter2NativePage(),
    });
    FlutterBoost.singleton.addBoostNavigatorObserver(NavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boost example',
      builder: FlutterBoost.init(postPush: _onRoutePushed),
      home: FirstScreen(),
    );
  }

  void _onRoutePushed(String pageName, String uniqueId, Map params, Route route, Future _) {}
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, opacity: 1, size: 20),
        brightness: Brightness.dark,
        title: Text('First Screen'),
        titleSpacing: 0,
        leading: IconButton(
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('Navigator Push 跳转 Flutter'),
              onPressed: () {
                // Navigate to the second screen when tapped.
                //Navigator.of(context).pushNamed("/second");
                //FlutterBoost.singleton.open('/second');    //FIXME FlutterBoost.singleton.open('/second') 通过INative 监听跳转
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new SecondScreen()),
                );
              },
            ),
            RaisedButton(
              child: Text('Flutter 跳转 Flutter'),
              onPressed: () {
                // FirstPage 跳转 SecondPage (有参 + 返回值)
                FlutterBoost.singleton.open('/second', urlParams: {'params_name': '李四', 'params_age': 28}).then((Map value) {
                  print('Second Page 页面销毁时获取的返回结果 result =  $value');
                });
              },
            ),
            RaisedButton(
              child: Text('Flutter 跳转 Native'),
              onPressed: () {
                FlutterBoost.singleton.open('/flutter2native');
              },
            ),
            RaisedButton(
              child: Text('Flutter 跳转 FlutterPlugin'),
              onPressed: () {
                FlutterBoost.singleton.open('/flutterPlugin');
              },
            ),
            RaisedButton(
              child: Text('Flutter 返回 Native'),
              onPressed: () {
                BoostContainerSettings settings = BoostContainer.of(context).settings;
                FlutterBoost.singleton.close(settings.uniqueId, result: {"result": "data from flutter"});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  SecondScreen({Map args}) {
    print('args = $args');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
        leading: IconButton(
          iconSize: 17,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
            BoostContainerSettings settings = BoostContainer.of(context).settings;
            FlutterBoost.singleton.close(settings.uniqueId, result: {"result": "data from flutter"});
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
