import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter View Controller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const methodChannel = MethodChannel('main.channel/homepage');

  int _counter = 0;
  String _batteryLevel = "null";

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = '$result';
    } on PlatformException catch (e) {
      batteryLevel = 'Error';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  void _popView() {
    try {
      methodChannel.invokeMethod('popFlutterView', [_counter]);
    } on PlatformException catch (e) {
      // Error
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                'Battery Level: $_batteryLevel%'
              ),
            ),
            MaterialButton(
              child: const Text('Get Battery Level'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: _getBatteryLevel,
            ),
            MaterialButton(
              child: const Text('Pop Flutter View Controller'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: _popView,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
