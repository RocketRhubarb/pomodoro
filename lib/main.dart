import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.red[200],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration _totalTime;
  Duration _tick;
  Duration _remainingTime;

  @override
  void initState() {
    setState(() {
      _totalTime = Duration(seconds: 1);
      _tick = Duration(milliseconds: 100);
      _remainingTime = _totalTime;
    });
  }

  void updateTime() {
    setState(() {
      _remainingTime -= _tick;
    });
  }

  void startCountdown() {
    Timer.periodic(_tick, (timer) {
      if (_remainingTime.inMilliseconds <= 0) {
        timer.cancel();
      } else {
        updateTime();
      }
    });
  }

  void resetTime() {
    setState(() {
      _remainingTime = _totalTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Remaing time: ${_remainingTime.inMilliseconds} seconds'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: startCountdown,
                  child: Text('start'),
                ),
                RaisedButton(
                  onPressed: resetTime,
                  child: Text('reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
