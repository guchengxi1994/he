import 'dart:async';

import 'package:flutter/material.dart';

class RotationController {
  final ValueNotifier<double> rotationNotifier = ValueNotifier(0.0);

  double get rotation => rotationNotifier.value;

  void dispose() {
    rotationNotifier.dispose();
    _timer.cancel();
  }

  void reset() {
    rotationNotifier.value = 0.0;
  }

  void pause() {
    _timer.cancel();
  }

  void start() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      rotationNotifier.value += 1;
    });
  }

  RotationController() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      rotationNotifier.value = rotationNotifier.value + 1;
    });
  }
  late Timer _timer;
}
