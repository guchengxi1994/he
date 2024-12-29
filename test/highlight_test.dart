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
        appBar: AppBar(title: const Text("高亮示例")),
        body: Center(
          child: HighlightRow(),
        ),
      ),
    );
  }
}

class HighlightRow extends StatelessWidget {
  const HighlightRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 原始 Row 组件
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
        // 高亮遮罩
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // 半透明遮罩
          ),
        ),
        // 高亮区域
        Positioned(
          right: 0,
          width: 100, // 高亮区域的宽度
          height: 50, // 高亮区域的高度
          child: Container(
            color: Colors.transparent, // 设置透明以让底层内容可见
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2), // 高亮边框
              ),
            ),
          ),
        ),
      ],
    );
  }
}
