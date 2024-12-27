import 'package:flutter/material.dart';
import 'package:he/src/common/loading_controller.dart';

import 'basic_paint.dart';

class TaichiProgressBar extends StatelessWidget {
  const TaichiProgressBar(
      {super.key,
      required this.controller,
      this.lineLength = 200,
      this.size = 30,
      this.backgroundColor = const Color.fromARGB(255, 223, 222, 222),
      this.radius = 16,
      this.label});
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
              return Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 176, 232, 243),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  width: getOffset((value + size / 2)),
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
                Positioned(
                    // max `lineLength - size`
                    left: getOffset(value),
                    top: 0,
                    child: SizedBox(
                        width: size,
                        height: size,
                        child: CustomPaint(
                            painter: BasicTaichiPainter(
                                angle: getScrollOffset(value)))))
              ]);
            }));
  }

  double getOffset(num v) {
    return v / 100 * (lineLength - size);
  }

  double getScrollOffset(num v) {
    return getOffset(v) / lineLength * 360;
  }
}
