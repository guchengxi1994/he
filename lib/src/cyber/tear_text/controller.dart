import 'dart:async';
import 'dart:math';

enum TearTextOperation { tear, resize }

class TearTextState {
  final List<TearTextOperation> operations;
  final String text;

  TearTextState({this.operations = const [], this.text = ''});

  TearTextState copyWith({
    List<TearTextOperation>? operations,
    String? text,
  }) {
    return TearTextState(
      operations: operations ?? this.operations,
      text: text ?? this.text,
    );
  }
}

class TearTextController {
  late Timer timer;
  late Timer recoverTimer;
  final String origin;
  String? target;
  final int speed;
  final int recoverSpeed;
  final int maxSteps;
  late final Random random = Random();
  int times = 0;
  late String currentText;

  late StreamController<TearTextState> streamController =
      StreamController<TearTextState>.broadcast();

  Stream<TearTextState> get stream => streamController.stream;

  TearTextController(
      {required this.origin,
      this.target,
      this.speed = 900,
      this.recoverSpeed = 1500,
      this.maxSteps = 30})
      : assert(speed != recoverSpeed &&
            speed > 0 &&
            recoverSpeed > 0 &&
            (target == null || target.length == origin.length)) {
    currentText = origin;
    target ??= origin;
    timer = Timer.periodic(Duration(milliseconds: speed), (_) {
      List<TearTextOperation> operations = [];
      for (final v in TearTextOperation.values) {
        if (random.nextBool()) {
          operations.add(v);
        }
      }
      String next = nextStep();
      streamController.sink.add(TearTextState(
          operations: operations,
          text: times <= (maxSteps * 0.15) ? origin : next));
    });
    recoverTimer = Timer.periodic(Duration(milliseconds: recoverSpeed), (_) {
      streamController.sink.add(TearTextState(
        operations: [],
      ));
    });
  }

  void dispose() {
    timer.cancel();
    recoverTimer.cancel();
  }

  /// 每次随机修改一个字符，返回修改后的字符串
  String nextStep() {
    if (times >= maxSteps) {
      // 如果已达到最大步数，直接将当前字符串替换为目标字符串
      currentText = target!;
    } else if (currentText != target) {
      // 随机选择一个不同的字符位置进行修改
      int indexToChange;
      do {
        indexToChange = random.nextInt(currentText.length);
      } while (currentText[indexToChange] == target![indexToChange]);

      // 修改字符
      currentText =
          replaceCharAt(currentText, indexToChange, target![indexToChange]);
      times++;
    }
    return currentText;
  }

  /// 替换字符串中指定位置的字符
  String replaceCharAt(String input, int index, String newChar) {
    return input.substring(0, index) + newChar + input.substring(index + 1);
  }
}
