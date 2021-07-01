import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class clockwidget extends StatelessWidget {
  final double time;
  final Color color;
  const clockwidget({Key? key, required this.time, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: clockPainter(color: color, time: time),
    );
  }
}

class clockPainter extends CustomPainter {
  final double time;
  final Color color;

  clockPainter({required this.color, required this.time})
      : blackpaintfill = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        blackpaintstroke = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round,
        minutehand = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round,
        hourhand = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;

  var blackpaintfill;
  var blackpaintstroke;
  var minutehand;
  var hourhand;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(50, 50), 30, blackpaintstroke);
    canvas.drawLine(Offset(50, 46), Offset(50, 27), minutehand);
    canvas.drawLine(
        Offset(50 - 5 * -math.sin(2 * math.pi * time / 12),
            50 - 5 * math.cos(2 * math.pi * time / 12)),
        Offset(50 - 20 * -math.sin(2 * math.pi * time / 12),
            50 - 20 * math.cos(2 * math.pi * time / 12)),
        hourhand);

    canvas.drawCircle(Offset(50, 50), 6, blackpaintfill);
  }

  @override
  bool shouldRepaint(clockPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(clockPainter oldDelegate) => false;
}
