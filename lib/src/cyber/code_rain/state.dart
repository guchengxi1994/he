import 'dart:math';

import 'char_set.dart';

class AnimatedTextState {
  final String text;
  final double offset;
  final int index;
  final int position;

  AnimatedTextState(
      {required this.offset,
      required this.text,
      required this.index,
      required this.position});

  AnimatedTextState copyWith({double? offset, String? text, int? position}) {
    return AnimatedTextState(
        offset: offset ?? this.offset,
        text: text ?? this.text,
        index: index,
        position: position ?? this.position);
  }

  @override
  bool operator ==(Object other) {
    if (other is AnimatedTextState) {
      return index == other.index;
    }
    return false;
  }

  @override
  String toString() {
    return "AnimatedTextState(offset: $offset, text: $text, index: $index)";
  }

  @override
  int get hashCode => index.hashCode;
}

class CodeRainState {
  final List<AnimatedTextState> texts;
  CodeRainState({this.texts = const []});

  CodeRainState copyWith({List<AnimatedTextState>? texts}) {
    return CodeRainState(texts: texts ?? this.texts);
  }

  bool hasTextOnBoard(int length) {
    return texts.any((element) => element.offset + 16 * length >= -16);
  }

  int getRandomPosition(double bound, {List<int> excluded = const []}) {
    int k = bound ~/ 16;
    List<int> current = texts.map((e) => e.position).toList()..addAll(excluded);
    List<int> reserved = List<int>.generate(k, (index) => index)
      ..retainWhere((v) => !current.contains(v))
      ..shuffle();

    return reserved[0];
  }

  CodeRainState changeByIndex(int index, AnimatedTextState text) {
    var newTexts = texts.toList();
    newTexts[index] = text;
    return CodeRainState(texts: newTexts);
  }

  CodeRainState init(int count, int stringLength, double bound) {
    List<int> current = [];
    var texts = List.generate(count, (index) {
      int p = getRandomPosition(bound, excluded: current);
      current.add(p);
      return AnimatedTextState(
          text: CharSetUtil.getRandom(stringLength),
          offset: -stringLength * 16 * (1 + Random().nextDouble()),
          position: p,
          index: index);
    });
    return CodeRainState(texts: texts);
  }
}
