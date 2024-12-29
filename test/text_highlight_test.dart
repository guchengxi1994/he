import 'package:flutter/material.dart';

class HighlightedTextExample extends StatelessWidget {
  const HighlightedTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.yellow, // 背景颜色
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withValues(alpha: 0.5), // 光晕颜色
                blurRadius: 10, // 模糊半径
                spreadRadius: 2, // 扩散半径
              ),
            ],
          ),
          child: Text(
            'Highlighted Text',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class HighlightedTextExample2 extends StatelessWidget {
  const HighlightedTextExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.yellow, // 背景颜色
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.5), // 光晕颜色
                blurRadius: 15, // 模糊半径
                spreadRadius: 5, // 扩散半径
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'Highlighted Text',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

class HighlightedTextExample3 extends StatelessWidget {
  const HighlightedTextExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          colors: [Colors.yellow, Colors.transparent],
          center: Alignment.topCenter,
          radius: 0.1,
        ).createShader(bounds);
      },
      child: Text(
        'Highlighted Text'.split("").join("\n"),
        style: TextStyle(
          fontSize: 24,
          color: Colors.green, // 设置文字颜色
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
        home: Scaffold(
      body: Column(
        spacing: 20,
        children: [
          // SizedBox(width: 1000, height: 100, child: HighlightedTextExample()),
          // SizedBox(width: 1000, height: 100, child: HighlightedTextExample2()),
          SizedBox(
              // color: Colors.black,
              width: 100,
              height: 300,
              child: HighlightedTextExample3())
        ],
      ),
    )));
