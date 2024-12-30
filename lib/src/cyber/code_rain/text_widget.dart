import 'package:flutter/material.dart';
import 'package:he/src/cyber/code_rain/controller.dart';

import 'state.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.state,
      required this.direction,
      required this.style});
  final AnimatedTextState state;
  final Direction direction;
  final TextStyle style;

  Widget _shadowWrapper(Widget child) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.greenAccent.withValues(alpha: 0.3), Colors.greenAccent],
        stops: [0.2, 0.9],
      ).createShader(rect),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    String text = state.text.substring(0, state.text.length - 1);
    String finalChar = state.text.substring(state.text.length - 1);
    if (direction == Direction.bottomToTop ||
        direction == Direction.topToBottom) {
      return Positioned(
          top: state.offset,
          left: state.position * 16,
          child: _shadowWrapper(Column(
            children: [
              ...text.split("").map((e) => SizedBox(
                  width: 16,
                  height: 16,
                  child: Center(
                    child: Text(
                      e,
                      style: style,
                    ),
                  ))),
              _lastCharWrapper(finalChar)
            ],
          )));
    } else {
      return Positioned(
          left: state.offset,
          top: state.position * 16,
          child: _shadowWrapper(Row(
            children: [
              ...text.split("").map((e) => SizedBox(
                  width: 16,
                  height: 16,
                  child: Center(
                    child: Text(
                      e,
                      style: style,
                    ),
                  ))),
              _lastCharWrapper(finalChar)
            ],
          )));
    }
  }

  Widget _lastCharWrapper(String s) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _style = style.copyWith(
      fontWeight: FontWeight.bold,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 5
        ..color = Colors.white,
      shadows: const [
        Shadow(
          blurRadius: 10,
          color: Colors.white,
          offset: Offset(0, 0),
        ),
        Shadow(
          blurRadius: 20,
          color: Colors.white30,
          offset: Offset(0, 0),
        ),
      ],
    );

    return SizedBox(
      width: 16,
      height: 16,
      child: Center(
        child: Text(
          s,
          style: _style,
        ),
      ),
    );
  }
}
