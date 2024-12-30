import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

class RandomTearingClipper extends CustomClipper<Path> {
  List<Offset> generatePoint() {
    List<Offset> points = [];
    var x = -1.0;
    var y = -1.0;
    for (var i = 0; i < 60; i++) {
      if (i % 2 != 0) {
        x = Random().nextDouble() * (Random().nextBool() ? -1 : 1);
      } else {
        y = Random().nextDouble() * (Random().nextBool() ? -1 : 1);
      }
      points.add(Offset(x, y));
    }
    return points;
  }

  @override
  Path getClip(Size size) {
    var points = generatePoint();
    var polygon = Polygon(points);
    return polygon.computePath(rect: Offset.zero & size);
  }

  @override
  bool shouldReclip(RandomTearingClipper oldClipper) => true;
}

class SizeClipper extends CustomClipper<Rect> {
  final double top;
  final double bottomAspectRatio;

  SizeClipper({required this.top, required this.bottomAspectRatio});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, top, size.width, size.height / bottomAspectRatio);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
