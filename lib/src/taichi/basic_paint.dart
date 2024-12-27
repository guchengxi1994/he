import 'package:flutter/material.dart';
import 'dart:math' as math;

class BasicTaichiPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double angle;

  BasicTaichiPainter({
    this.color1 = Colors.black,
    this.color2 = Colors.white,
    this.angle = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    // Rotate the canvas
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle * math.pi / 180);
    canvas.translate(-center.dx, -center.dy);

    final Paint paint1 = Paint()..color = color1;
    final Paint paint2 = Paint()..color = color2;

    // Draw the main circle
    canvas.drawCircle(center, radius, paint2);

    // Draw the left half circle
    final Rect leftHalfCircle = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(leftHalfCircle, math.pi / 2, math.pi, false, paint1);

    // Draw the top small circle
    final Offset topCircleCenter = Offset(center.dx, center.dy - radius / 2);
    canvas.drawCircle(topCircleCenter, radius / 2, paint2);

    // Draw the bottom small circle
    final Offset bottomCircleCenter = Offset(center.dx, center.dy + radius / 2);
    canvas.drawCircle(bottomCircleCenter, radius / 2, paint1);

    // Draw the small black dot
    final Offset blackDotCenter = Offset(center.dx, center.dy - radius / 2);
    canvas.drawCircle(blackDotCenter, radius / 8, paint1);

    // Draw the small white dot
    final Offset whiteDotCenter = Offset(center.dx, center.dy + radius / 2);
    canvas.drawCircle(whiteDotCenter, radius / 8, paint2);

    // Restore the canvas
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
