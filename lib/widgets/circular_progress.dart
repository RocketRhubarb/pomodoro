import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final Color progressColor;
  final Color lineColor;
  final double fractionElapsed;
  final double width;

  CircularProgress(
      {this.progressColor, this.lineColor, this.fractionElapsed, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: CustomPaint(
        foregroundPainter: CirclePainter(
          progressColor: progressColor,
          lineColor: lineColor,
          fractionElapsed: fractionElapsed,
          width: width,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  Color progressColor;
  Color lineColor;
  double fractionElapsed;
  double width;

  CirclePainter(
      {this.progressColor, this.lineColor, this.fractionElapsed, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint progress = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    double arcAngle = 2 * pi * fractionElapsed;

    canvas.drawCircle(center, radius, line);

    canvas.drawArc(rect, -pi / 2, arcAngle, false, progress);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
