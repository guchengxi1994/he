import 'package:flutter/material.dart';
import 'package:he/src/cyber/code_rain/controller.dart';

import 'text_widget.dart';

class CodeRain extends StatefulWidget {
  const CodeRain(
      {super.key,
      this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
      this.bgColor = const Color.fromARGB(255, 22, 22, 22),
      required this.controller});

  // final int fontSize;
  final Color bgColor;
  final TextStyle textStyle;
  final CodeRainController controller;

  @override
  State<CodeRain> createState() => _CodeRainState();
}

class _CodeRainState extends State<CodeRain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.controller.stream,
        builder: (c, s) {
          if (!s.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Container(
                width: widget.controller.width,
                height: widget.controller.height,
                decoration: BoxDecoration(color: widget.bgColor),
              ),
              ...s.data!.texts.map((e) {
                return TextWidget(
                  state: e,
                  direction: widget.controller.direction,
                  style: widget.textStyle,
                );
              })
            ],
          );
        });
  }
}
