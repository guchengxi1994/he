// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:he/src/common/loading_controller.dart';

/// [ProgressbarType.middle2side]
class TaichiProgressBar2 extends StatelessWidget {
  TaichiProgressBar2(
      {super.key,
      required this.controller,
      this.lineLength = 200,
      this.size = 30,
      this.backgroundColor = const Color.fromARGB(255, 223, 222, 222),
      this.radius = 16,
      this.label}) {
    assert(size < lineLength);
  }

  final LoadingController controller;
  final double size;
  final double lineLength;
  final Color backgroundColor;
  final double radius;
  final String? label;

  @override
  Widget build(BuildContext context) {
    var docoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.white, // 高光部分
          offset: Offset(-5, -5),
          blurRadius: 10,
        ),
        BoxShadow(
          color: Colors.grey[500]!, // 阴影部分
          offset: Offset(5, 5),
          blurRadius: 10,
        ),
      ],
    );
    return Container(
        width: lineLength,
        decoration: docoration,
        height: 30,
        child: ValueListenableBuilder(
            valueListenable: controller.value,
            builder: (context, value, child) {
              return Stack(
                children: [
                  Center(
                    child: _TaichiSplitWidget(
                      progress: value,
                      taichiSize: size,
                      width: lineLength,
                      bgColor: backgroundColor,
                    ),
                  ),
                  Center(
                    child: Text(
                      label ?? "${value.toString()}%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }));
  }
}

class _TaichiSplitWidget extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color bgColor;

  /// 0-100
  final int progress;
  final double taichiSize;
  final double width;

  const _TaichiSplitWidget(
      {this.color1 = Colors.black,
      this.color2 = Colors.white,
      this.progress = 0,
      required this.taichiSize,
      required this.width,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    var childWidth = ((progress / 100) * (width - taichiSize)) + taichiSize;
    var distance = (progress / 100) * (width - taichiSize) / 2;
    return SizedBox(
      width: childWidth,
      height: taichiSize,
      child: Center(
        child: Container(
          height: taichiSize,
          width: childWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(0.5 * taichiSize),
          ),
          child: Stack(children: [
            // left side
            Positioned(
                child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(taichiSize),
                  topLeft: Radius.circular(taichiSize)),
              child: Container(
                  height: taichiSize,
                  width: 0.5 * taichiSize,
                  decoration: BoxDecoration(
                    color: color1,
                  )),
            )),

            Positioned(
                top: 0,
                left: 0.25 * taichiSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(taichiSize),
                      topLeft: Radius.circular(taichiSize)),
                  child: Container(
                      height: 0.5 * taichiSize,
                      width: 0.5 * taichiSize,
                      decoration: BoxDecoration(
                        color: bgColor,
                      )),
                )),

            Positioned(
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(taichiSize),
                      topRight: Radius.circular(taichiSize)),
                  child: Container(
                      height: taichiSize,
                      width: 0.5 * taichiSize,
                      decoration: BoxDecoration(
                        color: color2,
                      )),
                )),

            Positioned(
                bottom: 0,
                right: 0.25 * taichiSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(taichiSize),
                      topRight: Radius.circular(taichiSize)),
                  // BorderRadius.only(bottomLeft: Radius.circular(0.25 * size)),
                  child: Container(
                    height: 0.5 * taichiSize,
                    width: 0.5 * taichiSize,
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                  ),
                )),

            // center  circle
            Positioned(
                top: 0,
                left: 2 * distance + 0.25 * taichiSize,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(0.25 * taichiSize)),
                  // BorderRadius.only(bottomLeft: Radius.circular(0.25 * size)),
                  child: Container(
                      height: 0.5 * taichiSize,
                      width: 0.5 * taichiSize,
                      decoration: BoxDecoration(
                        color: color2,
                      )),
                )),

            // center  circle
            Positioned(
                bottom: 0,
                right: 0.25 * taichiSize + 2 * distance,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(0.25 * taichiSize)),
                  // BorderRadius.only(bottomLeft: Radius.circular(0.25 * size)),
                  child: Container(
                    height: 0.5 * taichiSize,
                    width: 0.5 * taichiSize,
                    decoration: BoxDecoration(
                      color: color1,
                    ),
                  ),
                )),

            // small black dot

            Positioned(
                top: 0.125 * taichiSize * 1.5,
                left:
                    0.5 * taichiSize - 0.125 * 0.5 * taichiSize + 2 * distance,
                height: 0.125 * taichiSize,
                width: 0.125 * taichiSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(0.125 * taichiSize),
                  ),
                )),

            // small white dot
            Positioned(
                bottom: 0.125 * 1.5 * taichiSize,
                left: 0.5 * taichiSize - 0.125 * 0.5 * taichiSize,
                height: 0.125 * taichiSize,
                width: 0.125 * taichiSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(0.125 * taichiSize),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
