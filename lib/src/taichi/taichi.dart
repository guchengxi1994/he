import 'package:flutter/material.dart';

import 'basic.dart';
import 'basic_paint.dart';
import 'complex.dart';

class Taichi {
  static basic(
      {double size = 100,
      Color color1 = Colors.black,
      Color color2 = Colors.white,
      double angle = 0}) {
    return BasicTaichi(
      size: size,
      color1: color1,
      color2: color2,
      angle: angle,
    );
  }

  static paintBasic(
      {double size = 100,
      Color color1 = Colors.black,
      Color color2 = Colors.white,
      double angle = 0,
      Widget? child}) {
    return SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: BasicTaichiPainter(),
          child: child,
        ));
  }

  static Widget complex(
      {double size = 300,
      Color color1 = const Color.fromARGB(255, 13, 26, 46),
      Color color2 = const Color.fromARGB(255, 176, 232, 243),
      double? angle}) {
    return ComplexTaichi(size: size, color1: color1, color2: color2);
  }
}
