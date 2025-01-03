import 'package:flutter/material.dart';
import 'dart:math' as math;

class BasicTaichi extends StatelessWidget {
  const BasicTaichi(
      {super.key,
      this.size = 100,
      this.color1 = Colors.black,
      this.color2 = Colors.white,
      this.angle = 0})
      : assert(color1 != color2 && size > 0);
  final double size;
  final Color color1;
  final Color color2;

  /// rotated angle
  /// eg. 0,90,180,-90,...
  final double? angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Transform.rotate(
          angle: angle! / 180 * math.pi,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.circular(0.5 * size),
                border: Border.all(color: color1)),
            child: Stack(children: [
              // left side
              Positioned(
                  child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size),
                    topLeft: Radius.circular(size)),
                child: Container(
                    height: size,
                    width: 0.5 * size,
                    decoration: BoxDecoration(
                        color: color1,
                        border: Border(left: BorderSide(color: color1)))),
              )),

              // center  circle
              Positioned(
                  top: 0,
                  left: 0.25 * size,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(0.25 * size)),
                    // BorderRadius.only(bottomLeft: Radius.circular(0.25 * size)),
                    child: Container(
                        height: 0.5 * size,
                        width: 0.5 * size,
                        decoration: BoxDecoration(
                          color: color2,
                        )),
                  )),

              // center  circle
              Positioned(
                  bottom: 0,
                  right: 0.25 * size,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(0.25 * size)),
                    // BorderRadius.only(bottomLeft: Radius.circular(0.25 * size)),
                    child: Container(
                      height: 0.5 * size,
                      width: 0.5 * size,
                      decoration: BoxDecoration(
                        color: color1,
                      ),
                    ),
                  )),

              // small black dot

              Positioned(
                  top: 0.125 * size * 1.5,
                  left: 0.5 * size - 0.125 * 0.5 * size,
                  height: 0.125 * size,
                  width: 0.125 * size,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.circular(0.125 * size),
                    ),
                  )),

              // small white dot
              Positioned(
                  bottom: 0.125 * 1.5 * size,
                  left: 0.5 * size - 0.125 * 0.5 * size,
                  height: 0.125 * size,
                  width: 0.125 * size,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color2,
                      borderRadius: BorderRadius.circular(0.125 * size),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
