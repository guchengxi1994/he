import 'package:flutter/material.dart';
import 'package:he/src/common/rotation_controller.dart';
import 'dart:math' as math;

import 'package:he/src/taichi/taichi.dart';

const double _factor = 1 / 6;
const double _factor2 = _factor / 2;
const double _trigramWidth = 30;
const double _gap = 20;

class EightTrigrams extends StatelessWidget {
  const EightTrigrams({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: EightTrigramsPainter(),
        child: Center(
          child: Taichi.basic(size: size / 2),
        ),
      ),
    );
  }
}

class AnimatedEightTrigrams extends StatelessWidget {
  AnimatedEightTrigrams({super.key, required this.size});
  final double size;
  late final RotationController _controller = RotationController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller.rotationNotifier,
        builder: (c, s, _) {
          return Transform.rotate(
            angle: s / 180 * 3.14,
            child: SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: EightTrigramsPainter(),
                child: Center(
                  child: Transform.rotate(
                    angle: -2 * s / 180 * 3.14,
                    child: Taichi.basic(size: size / 2),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

/// 八卦 [Bagua]
class EightTrigramsPainter extends CustomPainter {
  final Color color;

  EightTrigramsPainter({
    this.color = Colors.black,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.width / 2;
    double trigramWidth = _trigramWidth * size.width / 800;
    double gap = _gap * size.width / 800;

    late double x1 = -_factor2 * size.width;
    late double x2 = x1 + _factor * size.width / 2 + gap / 2;
    late double y1 = 0;
    late double y2 = y1 + trigramWidth + gap;
    late double y3 = y2 + trigramWidth + gap;
    canvas.translate(radius, radius);
    canvas.save();

    // 离
    canvas.translate(0, -radius);
    _paintLi(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 坤
    canvas.restore();
    // _printMatrix(canvas);
    canvas.save();
    canvas.translate(radius * math.cos(1 / 4 * math.pi),
        -radius * math.sin(1 / 4 * math.pi));
    // _printMatrix(canvas);
    canvas.rotate(1 / 4 * math.pi);
    // _printMatrix(canvas);
    _paintKun(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 兑
    canvas.restore();
    canvas.save();
    canvas.translate(radius, 0);
    // _printMatrix(canvas);
    canvas.rotate(1 / 2 * math.pi);
    _paintDui(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 乾
    canvas.restore();
    canvas.save();
    canvas.translate(
        radius * math.cos(1 / 4 * math.pi), radius * math.sin(3 / 4 * math.pi));
    canvas.rotate(3 / 4 * math.pi);
    _paintQian(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 坎
    canvas.restore();
    canvas.save();
    canvas.translate(0, radius);
    canvas.rotate(1 * math.pi);
    _paintKan(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 艮
    canvas.restore();
    canvas.save();
    canvas.translate(-radius * math.cos(1 / 4 * math.pi),
        radius * math.sin(1 / 4 * math.pi));
    canvas.rotate(5 / 4 * math.pi);
    _paintGen(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 震
    canvas.restore();
    canvas.save();
    canvas.translate(-radius, 0);
    canvas.rotate(6 / 4 * math.pi);
    _paintZhen(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    // 巽
    canvas.restore();
    canvas.save();
    canvas.translate(-radius * math.cos(1 / 4 * math.pi),
        -radius * math.sin(1 / 4 * math.pi));
    canvas.rotate(7 / 4 * math.pi);
    _paintXun(canvas, size, paint, x1, x2, y1, y2, y3, trigramWidth, gap);

    canvas.restore();
  }

  void _paintLi(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop = Offset(x1, y1) & Size(size.width * _factor, tw);
    Rect rectMiddle1 =
        Offset(x1, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle2 =
        Offset(x2, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom = Offset(x1, y3) & Size(size.width * _factor, tw);

    canvas.drawRect(rectTop, paint);
    canvas.drawRect(rectMiddle1, paint);
    canvas.drawRect(rectMiddle2, paint);
    canvas.drawRect(rectBottom, paint);
  }

  void _paintKun(Canvas canvas, Size size, Paint paint, double x1, x2,
      double y1, y2, y3, tw, g) {
    Rect rectTop1 = Offset(x1, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectTop2 = Offset(x2, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle1 =
        Offset(x1, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle2 =
        Offset(x2, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom1 =
        Offset(x1, y3) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom2 =
        Offset(x2, y3) & Size(size.width * _factor / 2 - g / 2, tw);

    canvas.drawRect(rectTop1, paint);
    canvas.drawRect(rectTop2, paint);
    canvas.drawRect(rectMiddle1, paint);
    canvas.drawRect(rectMiddle2, paint);
    canvas.drawRect(rectBottom1, paint);
    canvas.drawRect(rectBottom2, paint);
  }

  void _paintDui(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop1 = Offset(x1, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectTop2 = Offset(x2, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle = Offset(x1, y2) & Size(size.width * _factor, tw);
    Rect rectBottom = Offset(x1, y3) & Size(size.width * _factor, tw);

    canvas.drawRect(rectTop1, paint);
    canvas.drawRect(rectTop2, paint);
    canvas.drawRect(rectMiddle, paint);
    canvas.drawRect(rectBottom, paint);
  }

  void _paintQian(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop = Offset(x1, y1) & Size(size.width * _factor, tw);
    Rect rectMiddle = Offset(x1, y2) & Size(size.width * _factor, tw);
    Rect rectBottom = Offset(x1, y3) & Size(size.width * _factor, tw);
    canvas.drawRect(rectTop, paint);
    canvas.drawRect(rectMiddle, paint);
    canvas.drawRect(rectBottom, paint);
  }

  void _paintKan(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop1 = Offset(x1, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectTop2 = Offset(x2, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle = Offset(x1, y2) & Size(size.width * _factor, tw);
    Rect rectBottom1 =
        Offset(x1, y3) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom2 =
        Offset(x2, y3) & Size(size.width * _factor / 2 - g / 2, tw);

    canvas.drawRect(rectTop1, paint);
    canvas.drawRect(rectTop2, paint);
    canvas.drawRect(rectMiddle, paint);
    canvas.drawRect(rectBottom1, paint);
    canvas.drawRect(rectBottom2, paint);
  }

  void _paintGen(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop = Offset(x1, y1) & Size(size.width * _factor, tw);
    Rect rectMiddle1 =
        Offset(x1, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle2 =
        Offset(x2, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom1 =
        Offset(x1, y3) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom2 =
        Offset(x2, y3) & Size(size.width * _factor / 2 - g / 2, tw);
    canvas.drawRect(rectTop, paint);
    canvas.drawRect(rectMiddle1, paint);
    canvas.drawRect(rectMiddle2, paint);
    canvas.drawRect(rectBottom1, paint);
    canvas.drawRect(rectBottom2, paint);
  }

  void _paintZhen(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop1 = Offset(x1, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectTop2 = Offset(x2, y1) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle1 =
        Offset(x1, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectMiddle2 =
        Offset(x2, y2) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom = Offset(x1, y3) & Size(size.width * _factor, tw);

    canvas.drawRect(rectTop1, paint);
    canvas.drawRect(rectTop2, paint);
    canvas.drawRect(rectMiddle1, paint);
    canvas.drawRect(rectMiddle2, paint);
    canvas.drawRect(rectBottom, paint);
  }

  void _paintXun(
      Canvas canvas, Size size, Paint paint, double x1, x2, y1, y2, y3, tw, g) {
    Rect rectTop = Offset(x1, y1) & Size(size.width * _factor, tw);
    Rect rectMiddle = Offset(x1, y2) & Size(size.width * _factor, tw);
    Rect rectBottom1 =
        Offset(x1, y3) & Size(size.width * _factor / 2 - g / 2, tw);
    Rect rectBottom2 =
        Offset(x2, y3) & Size(size.width * _factor / 2 - g / 2, tw);

    canvas.drawRect(rectTop, paint);
    canvas.drawRect(rectMiddle, paint);
    canvas.drawRect(rectBottom1, paint);
    canvas.drawRect(rectBottom2, paint);
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
