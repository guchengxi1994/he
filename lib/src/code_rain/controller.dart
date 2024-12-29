import 'dart:async';

import 'package:he/src/code_rain/char_set.dart';
import 'package:he/src/code_rain/state.dart';

enum Direction { leftToRight, rightToLeft, topToBottom, bottomToTop }

extension DirectionExtension on Direction {
  bool get isHorizontal =>
      this == Direction.leftToRight || this == Direction.rightToLeft;
  bool get isVertical =>
      this == Direction.topToBottom || this == Direction.bottomToTop;
}

class CodeRainController {
  final int count;
  final int stringLength;
  late CodeRainState state;
  late Timer timer;
  final double width;
  final double height;
  final Direction direction;
  final double speed;

  late StreamController<CodeRainState> streamController =
      StreamController<CodeRainState>();

  Stream<CodeRainState> get stream => streamController.stream;

  void dispose() {
    timer.cancel();
    streamController.close();
  }

  CodeRainController(
      {required this.count,
      required this.stringLength,
      this.height = 200,
      this.width = 300,
      this.direction = Direction.topToBottom,
      this.speed = 3}) {
    double bound = direction.isHorizontal ? width : height;
    state = CodeRainState().init(count, stringLength, bound);
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      final texts = state.texts;

      for (var i = 0; i < texts.length; i++) {
        final text = texts[i];
        final offset = text.offset;
        final newOffset = offset + speed;
        if (!state.hasTextOnBoard(stringLength)) {
          texts[i] = text.copyWith(
              offset: -16.0 * texts[i].text.length,
              text: CharSetUtil.getPartialRandom(text.text),
              position: state.getRandomPosition(bound));
          continue;
        }

        if (newOffset > bound) {
          texts[i] = text.copyWith(
              offset: -16.0 * texts[i].text.length,
              text: CharSetUtil.getPartialRandom(text.text),
              position: state.getRandomPosition(bound));
        } else {
          texts[i] = text.copyWith(
              offset: newOffset, text: CharSetUtil.getPartialRandom(text.text));
        }
      }
      state = state.copyWith(texts: texts);
      streamController.sink.add(state);
    });
  }
}
