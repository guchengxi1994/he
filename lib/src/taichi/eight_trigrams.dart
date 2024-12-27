import 'package:flutter/material.dart';
import 'dart:math' as math;

const double _factor = 1 / 6;
const double _factor2 = _factor / 2;
const double _trigramWidth = 30;
const double _gap = 20;

/// 八卦 [Bagua]
class EightTrigrams extends CustomPainter {
  final Color color;

  EightTrigrams({
    this.color = Colors.black,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.width / 2;

    late double x1 = -_factor2 * size.width;
    late double x2 = x1 + _factor * size.width / 2 + _gap / 2;
    late double y1 = 0;
    late double y2 = y1 + _trigramWidth + _gap;
    late double y3 = y2 + _trigramWidth + _gap;
    canvas.translate(radius, radius);
    canvas.save();

    // 离
    canvas.translate(0, -radius);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 坤
    canvas.restore();
    // _printMatrix(canvas);
    canvas.save();
    canvas.translate(radius * math.cos(1 / 4 * math.pi),
        -radius * math.sin(1 / 4 * math.pi));
    // _printMatrix(canvas);
    canvas.rotate(1 / 4 * math.pi);
    // _printMatrix(canvas);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 兑
    canvas.restore();
    canvas.save();
    canvas.translate(radius, 0);
    // _printMatrix(canvas);
    canvas.rotate(1 / 2 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 乾
    canvas.restore();
    canvas.save();
    canvas.translate(
        radius * math.cos(1 / 4 * math.pi), radius * math.sin(3 / 4 * math.pi));
    canvas.rotate(3 / 4 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 坎
    canvas.restore();
    canvas.save();
    canvas.translate(0, radius);
    canvas.rotate(1 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 艮
    canvas.restore();
    canvas.save();
    canvas.translate(-radius * math.cos(1 / 4 * math.pi),
        radius * math.sin(1 / 4 * math.pi));
    canvas.rotate(5 / 4 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 震
    canvas.restore();
    canvas.save();
    canvas.translate(-radius, 0);
    canvas.rotate(6 / 4 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    // 巽
    canvas.restore();
    canvas.save();
    canvas.translate(-radius * math.cos(1 / 4 * math.pi),
        -radius * math.sin(1 / 4 * math.pi));
    canvas.rotate(7 / 4 * math.pi);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3);

    canvas.restore();
  }

  void _paintLi(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3) {
    Rect rectTop = Offset(x1, y1) & Size(size.width * _factor, _trigramWidth);
    Rect rectMiddle1 = Offset(x1, y2) &
        Size(size.width * _factor / 2 - _gap / 2, _trigramWidth);
    Rect rectMiddle2 = Offset(x2, y2) &
        Size(size.width * _factor / 2 - _gap / 2, _trigramWidth);
    Rect rectBottom =
        Offset(x1, y3) & Size(size.width * _factor, _trigramWidth);

    canvas.drawRect(rectTop, paint);
    canvas.drawRect(rectMiddle1, paint);
    canvas.drawRect(rectMiddle2, paint);
    canvas.drawRect(rectBottom, paint);
  }

  /// for debug use
  // ignore: unused_element
  void _printMatrix(Canvas canvas) {
    final Matrix4 transform = Matrix4.fromFloat64List(canvas.getTransform());
    final Offset offset =
        Offset(transform.getTranslation().x, transform.getTranslation().y);

    debugPrint('当前原点坐标：$offset');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
