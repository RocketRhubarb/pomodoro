import 'dart:async';

import 'package:flutter/material.dart';
import './widgets/countdown_clock.dart';
import 'widgets/circular_progress.dart';

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
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _totalTime = Duration(
      minutes: 25,
    );
    _tick = Duration(
      milliseconds: 500,
    );
    _remainingTime = _totalTime;
  }

  void updateTime() {
    setState(() {
      _remainingTime -= _tick;
    });
  }

  void startCountdown() {
    if (timerPresent()) {
      setState(() {
        pauseTimer();
      });
    } else {
      _timer = Timer.periodic(_tick, (tmr) {
        if (_remainingTime.inMilliseconds <= 0) {
          tmr.cancel();
        } else {
          updateTime();
        }
      });
    }
  }

  void resetTime() {
    setState(() {
      pauseTimer();
      _remainingTime = _totalTime;
    });
  }

  void pauseTimer() {
    _timer.cancel();
    _timer = null;
  }

  bool timerPresent() => _timer != null;

  double fractionElapsed() {
    return 1.0 -
        _remainingTime.inMilliseconds.toDouble() /
            _totalTime.inMilliseconds.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: <Widget>[
                  CircularProgress(
                    fractionElapsed: fractionElapsed(),
                    progressColor: Colors.deepOrange,
                    lineColor: Colors.blueGrey[300],
                    width: 10.0,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CountdownClock(time: _remainingTime),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: startCountdown,
                  child: Text(timerPresent() ? 'pause' : 'start'),
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
