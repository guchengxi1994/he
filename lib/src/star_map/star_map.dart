import 'package:flutter/material.dart';

const double _singleMapWidth = 300;
const double _mapWidth = 12 * _singleMapWidth;
const double _mapHeight = 300;

extension OffsetExt on List<Offset> {
  List<Offset> addOffset(Offset offset) {
    return map((e) => e + offset).toList();
  }
}

class Constellation {
  final String name;
  final List<Offset> points; // 星座点
  final List<List<int>> lines; // 点之间的连接关系

  Constellation(this.name, this.points, this.lines);
}

class StarMapPainter extends CustomPainter {
  final double viewWindowWidth;
  StarMapPainter({this.viewWindowWidth = 400});

  @override
  void paint(Canvas canvas, Size size) {
    final double v = (_mapWidth - viewWindowWidth) / 2;
    Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color.fromARGB(255, 75, 0, 130),
          const Color.fromARGB(255, 0, 0, 128),
          const Color.fromARGB(255, 0, 32, 96),
        ], // 渐变的起始和结束颜色
        begin: Alignment.topLeft, // 渐变的起始位置
        end: Alignment.bottomRight, // 渐变的结束位置
      ).createShader(
          Rect.fromLTRB(-v, 0, viewWindowWidth + v, _mapHeight)); // 渐变区域

    canvas.drawRect(
        Rect.fromLTRB(-v, 0, viewWindowWidth + v, _mapHeight), backgroundPaint);

    canvas.save();
    List<Constellation> constellations = [
      _buildAries(),
      _buildTaurus(),
    ];
    for (int i = 0; i < constellations.length; i++) {
      canvas.restore();
      canvas.save();
      canvas.translate(-v + i * _singleMapWidth, 0);
      _paintConstellation(canvas, constellations[i]);
    }
    canvas.restore();
  }

  void _paintConstellation(Canvas canvas, Constellation constellation) {
    final pointPaint = Paint()
      ..color = const Color.fromARGB(255, 187, 218, 244)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    for (final point in constellation.points) {
      canvas.drawCircle(point, 5.0, pointPaint);
    }

    for (final line in constellation.lines) {
      final p1 = constellation.points[line[0]];
      final p2 = constellation.points[line[1]];
      canvas.drawLine(p1, p2, linePaint);
    }

    // 创建文字样式
    final textStyle = TextStyle(
        letterSpacing: 2.2,
        fontSize: 18,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.white,
        shadows: const [
          Shadow(
            blurRadius: 1,
            color: Colors.white30,
            offset: Offset(1, 1),
          ),
        ]);

    // 创建文字画笔
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // 设置文字内容
    textPainter.text = TextSpan(
      text: constellation.name,
      style: textStyle,
    );
    textPainter.layout(); // 计算文字布局

    double centerX = _singleMapWidth / 2;

    // 绘制文字
    textPainter.paint(
      canvas,
      Offset(
        centerX - textPainter.width / 2, // 水平方向居中
        20,
      ),
    );
  }

  Constellation _buildAries() {
    List<Offset> points = [
      Offset(50, 50),
      Offset(200, 100),
      Offset(230, 140),
      Offset(235, 160),
    ];
    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
    ];
    return Constellation('ARIES', points.addOffset(Offset(0, 50)), lines);
  }

  Constellation _buildTaurus() {
    // 14 points
    List<Offset> points = [
      /*0*/ Offset(50, 30),
      /*1*/ Offset(120, 70),
      /*2*/ Offset(130, 85),
      /*3*/ Offset(140, 100),
      /*4*/ Offset(150, 105),
      /*5*/ Offset(170, 125), // connection point1
      /*6*/ Offset(225, 150), // connection point2
      /*7*/ Offset(270, 130),
      /*8*/ Offset(290, 150), // line done
      /*9*/ Offset(200, 170),
      /*10*/ Offset(220, 190), // line done
      /*11*/ Offset(40, 100),
      /*12*/ Offset(120, 130),
      /*13*/ Offset(135, 135),
    ];
    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [11, 12],
      [12, 13],
      [13, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [6, 9],
      [9, 10]
    ];

    return Constellation(
        "Taurus".toUpperCase(), points.addOffset(Offset(0, 50)), lines);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StarMap extends StatelessWidget {
  const StarMap({super.key, required this.viewWindowWidth});
  final double viewWindowWidth;

  @override
  Widget build(BuildContext context) {
    final double v = (_mapWidth - viewWindowWidth) / 2;
    return SizedBox(
      width: viewWindowWidth,
      height: _mapHeight,
      child: InteractiveViewer(
          boundaryMargin: EdgeInsets.only(left: v, right: v),
          child: SizedBox(
            width: _mapWidth,
            height: _mapHeight,
            child: CustomPaint(
              size: Size(_mapWidth, _mapHeight),
              painter: StarMapPainter(viewWindowWidth: viewWindowWidth),
            ),
          )),
    );
  }
}
