import 'package:flutter/material.dart';

class CountdownClock extends StatelessWidget {
  final Duration time;

  CountdownClock({this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WatchFace(
          minutes: '${time.inMinutes.toString().padLeft(2, '0')}',
          seconds:
              '${time.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
    );
  }
}

class WatchFace extends StatelessWidget {
  final String minutes;
  final String seconds;

  const WatchFace({this.minutes, this.seconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$minutes:$seconds',
      style: TextStyle(
        fontSize: 60,
      ),
    );
  }
}
