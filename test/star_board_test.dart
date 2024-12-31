import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: InteractivePainter(),
  ));
}

class InteractivePainter extends StatelessWidget {
  const InteractivePainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Painter')),
      body: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(100), // 控制移动边界的范围
          minScale: 1, // 最小缩放比例
          maxScale: 1, // 最大缩放比例
          child: SizedBox(
            width: 500,
            height: 500,
            child: CustomPaint(
              size: Size(500, 500), // 画布的大小
              painter: MyPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.green], // 渐变的起始和结束颜色
        begin: Alignment.topLeft, // 渐变的起始位置
        end: Alignment.bottomRight, // 渐变的结束位置
      ).createShader(Rect.fromLTRB(-100, -100, 500, 500)); // 渐变区域

    // 绘制渐变背景
    canvas.drawRect(Rect.fromLTRB(-100, -100, 500, 500), backgroundPaint);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // 画一个矩形
    canvas.drawRect(Rect.fromLTWH(100, 100, 250, 250), paint);

    // 画一个圆形
    paint.color = Colors.red;
    canvas.drawCircle(Offset(200, 200), 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
