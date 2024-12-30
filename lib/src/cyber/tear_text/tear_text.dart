import 'dart:math';

import 'package:flutter/material.dart';
import 'package:he/src/cyber/tear_text/clippers.dart';

import 'controller.dart';

class TearText extends StatefulWidget {
  const TearText(
      {super.key,
      required this.controller,
      this.fontSize = 24,
      this.height = 180,
      this.width = 300});
  final TearTextController controller;
  final double fontSize;
  final double width;
  final double height;

  @override
  State<TearText> createState() => _TearTextState();
}

class _TearTextState extends State<TearText> {
  late Stream<TearTextState> stream = widget.controller.stream;

  Text textWidget(TearTextState state) {
    return Text(
      state.text,
      style: TextStyle(
          fontSize: widget.fontSize,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5
            ..color = Colors.white,
          shadows: const [
            Shadow(
              blurRadius: 10,
              color: Colors.white30,
              offset: Offset(0, 0),
            ),
            Shadow(
              blurRadius: 30,
              color: Colors.white30,
              offset: Offset(0, 0),
            ),
          ]),
    );
  }

  renderMainText(CustomClipper<Path>? clipper, Widget child) {
    return ClipPath(
      clipper: clipper,
      child: Center(
        child: child,
      ),
    );
  }

  double randomPosition(position) {
    return Random().nextInt(position).toDouble() *
        (Random().nextBool() ? -1 : 1);
  }

  renderResizedText(CustomClipper<Path>? clipper, Widget child) {
    return ClipPath(
      clipper: clipper,
      child: Container(
        alignment: Alignment.center,
        transform: Matrix4.translationValues(
            randomPosition(10), randomPosition(10), 0),
        padding: const EdgeInsets.only(top: 10),
        child: ClipRect(
          clipper: SizeClipper(top: 20, bottomAspectRatio: 2),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: Center(
        child: StreamBuilder(
            stream: stream,
            builder: (c, s) {
              if (!s.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final child = textWidget(s.data!);
              if (s.data!.operations.isNotEmpty) {
                if (s.data!.operations.contains(TearTextOperation.tear)) {
                  return renderMainText(RandomTearingClipper(), child);
                }
                if (s.data!.operations.contains(TearTextOperation.resize)) {
                  return renderResizedText(RandomTearingClipper(), child);
                }
                return renderMainText(RandomTearingClipper(), child);
              }
              return child;
            }),
      ),
    );
  }
}
