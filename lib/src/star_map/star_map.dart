import 'dart:math';

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

class Star {
  Offset position;
  double radius;
  double opacity;

  Star({required this.position, required this.radius, required this.opacity});

  factory Star.random(double width) {
    final random = Random();
    return Star(
      position: Offset(
          random.nextDouble() * (_mapWidth + width) - _mapWidth / 2,
          random.nextDouble() * (_mapHeight - 100) +
              50), // Replace with your screen size
      radius: random.nextDouble() * 2 + 1,
      opacity: random.nextDouble(),
    );
  }

  void update() {
    final random = Random();
    opacity = 0.5 + 0.5 * random.nextDouble(); // Randomize opacity for blinking
  }
}

class StarMapPainter extends CustomPainter {
  final double viewWindowWidth;
  StarMapPainter({this.viewWindowWidth = 400, required this.stars});
  final List<Star> stars;

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
      _buildGemini(),
      _buildCancer(),
      _buildLeo(),
      _buildVirgo(),
      _buildLibra(),
      _buildScorpio(),
      _buildSagittarius(),
      _buildCapricorn(),
      _buildAquarius(),
      _buildPisces()
    ];
    for (int i = 0; i < constellations.length; i++) {
      canvas.restore();
      canvas.save();
      canvas.translate(-v + i * _singleMapWidth, 0);
      _paintConstellation(canvas, constellations[i]);
    }
    canvas.restore();

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    for (var star in stars) {
      paint.color = Colors.white.withValues(alpha: star.opacity);
      canvas.drawCircle(star.position, star.radius, paint);
    }

    // Draw meteors
    // for (var meteor in meteors) {
    //   final meteorPaint = Paint()
    //     ..shader = LinearGradient(
    //       colors: [
    //         Colors.white.withValues(alpha: meteor.opacity),
    //         Colors.blue.withValues(alpha: meteor.opacity * 0.5),
    //       ],
    //       begin: Alignment.center,
    //       end: Alignment.topLeft,
    //     ).createShader(
    //         Rect.fromLTWH(meteor.position.dx, meteor.position.dy, 10, 10))
    //     ..style = PaintingStyle.fill;

    //   canvas.drawCircle(meteor.position, 2.0, meteorPaint);

    //   // Meteor trail
    //   final trailPaint = Paint()
    //     ..color = Colors.white.withValues(alpha: meteor.opacity * 0.2)
    //     ..strokeWidth = 2.0
    //     ..style = PaintingStyle.stroke;
    //   canvas.drawLine(
    //     meteor.position,
    //     meteor.position - meteor.velocity * 5, // Extend trail backward
    //     trailPaint,
    //   );
    // }
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
      Offset(255, 160),
      Offset(25, 70),
    ];
    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [4, 0],
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

  Constellation _buildGemini() {
    // 12 points
    List<Offset> points = [
      /*0*/ Offset(80, 80),
      /*1*/ Offset(50, 110),
      /*2*/ Offset(75, 140),
      /*3*/ Offset(110, 160),
      /*4*/ Offset(130, 180),
      /*5*/ Offset(170, 200), // connection point1
      /*6*/ Offset(190, 180),
      /*7*/ Offset(210, 160), // connection point2
      /*8*/ Offset(115, 100),
      /*9*/ Offset(100, 90),
      /*10*/ Offset(160, 220),
      /*11*/ Offset(230, 155),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 0],
      [5, 10],
      [7, 11]
    ];

    return Constellation("Gemini".toUpperCase(), points, lines);
  }

  Constellation _buildCancer() {
    // 5 points
    List<Offset> points = [
      /*0*/ Offset(150, 30),
      /*1*/ Offset(170, 100),
      /*2*/ Offset(160, 120),
      /*3*/ Offset(140, 160),
      /*4*/ Offset(190, 170),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [2, 4],
    ];

    return Constellation(
        "Cancer".toUpperCase(), points.addOffset(Offset(0, 59)), lines);
  }

  Constellation _buildLeo() {
    // 9 points
    List<Offset> points = [
      /*0*/ Offset(250, 60),
      /*1*/ Offset(230, 50),
      /*2*/ Offset(190, 65),
      /*3*/ Offset(180, 100), // connection point1
      /*4*/ Offset(210, 120),
      /*5*/ Offset(205, 160),
      /*6*/ Offset(100, 140),
      /*7*/ Offset(30, 160),
      /*8*/ Offset(90, 100),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [3, 8]
    ];

    return Constellation(
        "Leo".toUpperCase(), points.addOffset(Offset(0, 50)), lines);
  }

  Constellation _buildVirgo() {
    // 12 points
    List<Offset> points = [
      /*0*/ Offset(50, 50),
      /*1*/ Offset(40, 80),
      /*2*/ Offset(80, 90), // connection point1
      /*3*/ Offset(120, 80), // connection point2
      /*4*/ Offset(140, 60),
      /*5*/ Offset(160, 40),
      /*6*/ Offset(115, 120), // connection point3
      /*7*/ Offset(130, 160),
      /*8*/ Offset(80, 190),
      /*9*/ Offset(90, 130), // connection point4
      /*10*/ Offset(70, 160),
      /*11*/ Offset(30, 140),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      //
      [3, 6],
      [6, 7],
      [7, 8],
      //
      [6, 9],
      [9, 2],
      [9, 10],
      [10, 11],
    ];

    return Constellation(
        "Virgo".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  Constellation _buildLibra() {
    // 6 points
    List<Offset> points = [
      /*0*/ Offset(80, 50),
      /*1*/ Offset(50, 80),
      /*2*/ Offset(130, 90),
      /*3*/ Offset(40, 140),
      /*4*/ Offset(35, 150),
      /*5*/ Offset(110, 130),
    ];
    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 0],
      //
      [2, 5],
      [1, 3],
      [3, 4],
    ];
    return Constellation(
        "Libra".toUpperCase(), points.addOffset(Offset(80, 50)), lines);
  }

  Constellation _buildScorpio() {
    // 13 points
    List<Offset> points = [
      /*0*/ Offset(50, 130),
      /*1*/ Offset(70, 120),
      /*2*/ Offset(80, 125),
      /*3*/ Offset(60, 150),
      /*4*/ Offset(80, 170),
      /*5*/ Offset(120, 160),
      /*6*/ Offset(125, 120),
      /*7*/ Offset(130, 110),
      /*8*/ Offset(160, 80),
      /*9*/ Offset(170, 70),
      /*10*/ Offset(175, 65),
      /*11*/ Offset(200, 60), // connection point1
      /*12*/ Offset(180, 40),
      /*13*/ Offset(190, 75),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 9],
      [9, 10],
      [10, 11],
      [11, 12],
      [11, 13]
    ];

    return Constellation(
        "Scorpio".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  Constellation _buildSagittarius() {
    // 19 points
    List<Offset> points = [
      /*0*/ Offset(100, 200),
      /*1*/ Offset(100, 180),
      /*2*/ Offset(70, 190), // connection point1
      /*3*/ Offset(60, 170),
      /*4*/ Offset(50, 160),
      /*5*/ Offset(50, 130),
      /*6*/ Offset(80, 110),
      /*7*/ Offset(100, 135), // connection point2
      /*8*/ Offset(110, 145),
      /*9*/ Offset(125, 135), // connection point3
      /*10*/ Offset(115, 120),
      /*11*/ Offset(110, 100),
      /*12*/ Offset(100, 90),
      /*13*/ Offset(145, 125), // connection point4
      /*14*/ Offset(160, 110),
      /*15*/ Offset(140, 145),
      /*16*/ Offset(120, 165),
      /*17*/ Offset(130, 180),
      /*18*/ Offset(155, 155),
    ];
    List<List<int>> lines = [
      [0, 2],
      [1, 2],
      //
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      //
      [7, 8],
      [8, 9],
      [9, 10],
      [7, 10],
      //
      [10, 11],
      [11, 12],
      //
      [9, 13],
      [13, 14],
      [13, 15],
      [15, 16],
      [16, 17],
      [15, 18]
    ];

    return Constellation(
        "Sagittarius".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  Constellation _buildCapricorn() {
    // 11 points
    List<Offset> points = [
      /*0*/ Offset(50, 50),
      /*1*/ Offset(60, 55),
      /*2*/ Offset(75, 60),
      /*3*/ Offset(100, 70),
      /*4*/ Offset(150, 40), // connection point1
      /*5*/ Offset(135, 70),
      /*6*/ Offset(105, 110),
      /*7*/ Offset(100, 105),
      /*8*/ Offset(80, 95),
      /*9*/ Offset(65, 80),
      /*10*/ Offset(160, 30),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 9],
      [9, 0],
      [4, 10],
    ];

    return Constellation(
        "Capricorn".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  Constellation _buildAquarius() {
    // 13 points
    List<Offset> points = [
      /*0*/ Offset(50, 120),
      /*1*/ Offset(70, 90),
      /*2*/ Offset(65, 80),
      /*3*/ Offset(40, 60),
      /*4*/ Offset(100, 40),
      /*5*/ Offset(110, 50),
      /*6*/ Offset(120, 60),
      /*7*/ Offset(130, 50), // connection point1
      /*8*/ Offset(160, 80),
      /*9*/ Offset(180, 90),
      /*10*/ Offset(120, 70),
      /*11*/ Offset(130, 80),
      /*12*/ Offset(135, 85),
    ];

    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 9],
      [7, 10],
      [10, 11],
      [11, 12]
    ];

    return Constellation(
        "Aquarius".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  Constellation _buildPisces() {
    // 14 points
    List<Offset> points = [
      /*0*/ Offset(50, 50),
      /*1*/ Offset(40, 60),
      /*2*/ Offset(55, 70),
      /*3*/ Offset(65, 100),
      /*4*/ Offset(60, 130),
      /*5*/ Offset(45, 160),
      /*6*/ Offset(65, 140),
      /*7*/ Offset(85, 130),
      /*8*/ Offset(100, 110),
      /*9*/ Offset(120, 100), // connection point1
      /*10*/ Offset(130, 120),
      /*11*/ Offset(145, 130),
      /*12*/ Offset(160, 115),
      /*13*/ Offset(140, 100),
    ];
    List<List<int>> lines = [
      [0, 1],
      [1, 2],
      [0, 2],
      //
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 9],
      [9, 10],
      [10, 11],
      [11, 12],
      [12, 13],
      [13, 9]
    ];
    return Constellation(
        "Pisces".toUpperCase(), points.addOffset(Offset(30, 50)), lines);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StarMap extends StatefulWidget {
  const StarMap({super.key, required this.viewWindowWidth});
  final double viewWindowWidth;

  @override
  State<StarMap> createState() => _StarMapState();
}

class _StarMapState extends State<StarMap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    // _transformationController.addListener(() {
    //   final Offset offset = Offset(
    //       _transformationController.value.getTranslation().x,
    //       _transformationController.value.getTranslation().y);

    //   debugPrint('当前移动距离：$offset');
    // });

    // Initialize stars
    _stars = List.generate(200, (_) => Star.random(widget.viewWindowWidth));

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {
          // Update star opacity to simulate blinking
          for (var star in _stars) {
            star.update();
          }
        });
      })
      ..repeat(reverse: true);

    Future.delayed(Duration.zero, _generateMeteor);
  }

  // TODO: Generate meteors
  void _generateMeteor() async {}

  @override
  void dispose() {
    _controller.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double v = (_mapWidth - widget.viewWindowWidth) / 2;
    return SizedBox(
      width: widget.viewWindowWidth,
      height: _mapHeight,
      child: InteractiveViewer(
          transformationController: _transformationController,
          maxScale: 1,
          minScale: 1,
          boundaryMargin: EdgeInsets.only(left: v, right: v),
          child: SizedBox(
            width: _mapWidth,
            height: _mapHeight,
            child: CustomPaint(
              size: Size(_mapWidth, _mapHeight),
              painter: StarMapPainter(
                viewWindowWidth: widget.viewWindowWidth,
                stars: _stars,
              ),
            ),
          )),
    );
  }
}
