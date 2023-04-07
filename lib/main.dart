import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loopRunning = false;
  var bgColor = 0xFFFF0000;
  List<String> list = [];
  late Timer _bgColorTimer;
  late Timer _stringTimer;
  var i = 0;

  String generateRandomText(int length) {
    var rng = Random();
    const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rng.nextInt(chars.length))));
  }

  void _startLoop() {
    if(_loopRunning){
      return;
    }
    setState(() {
      _loopRunning = true;
    });

    _bgColorTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        if(i % 2 == 0) {
          bgColor = 0xFF0000FF;
        } else {
          bgColor = 0xFFFF0000;
        }
      });
    });

    _stringTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        list.add(generateRandomText(200000));
        i++;
      });
    });

    Timer(Duration(seconds: 30), () => _stopLoop());
  }

  void _stopLoop() {
    setState(() {
      _loopRunning = false;
      list = [];
      i = 0;
    });
    _bgColorTimer.cancel();
    _stringTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Color(bgColor)),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Marghoob Ahmad - 191ADB066'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                onPressed: _startLoop,
                child: _loopRunning ? Text('Started') : Text('Start'),
              ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
