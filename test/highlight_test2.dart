// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("光源效果示例")),
        body: Center(
          child: Column(
            spacing: 30,
            children: [GlowEffect(), HighlightWithGlow()],
          ),
        ),
      ),
    );
  }
}

class GlowEffect extends StatelessWidget {
  const GlowEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 普通部分
        Container(
          width: 100,
          height: 50,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text("左侧"),
        ),
        // 高亮部分
        Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.6), // 发光颜色
                blurRadius: 20, // 模糊程度
                spreadRadius: 5, // 扩散范围
              ),
            ],
          ),
          child: const Text(
            "右侧",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class HighlightWithGlow extends StatelessWidget {
  const HighlightWithGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 背景
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 50,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text("左侧"),
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text("右侧"),
            ),
          ],
        ),
        // 发光效果
        Positioned(
          right: 50,
          child: Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: RadialGradient(
                colors: [
                  Colors.green.withOpacity(0.6), // 发光中心颜色
                  Colors.transparent, // 外部透明
                ],
                radius: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
