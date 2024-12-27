import 'package:flutter/material.dart';

class LoadingController {
  /// 显示加载进度
  ///
  /// [value] 0-100
  final ValueNotifier<int> _val = ValueNotifier(0);

  ValueNotifier<int> get value => _val;

  repeat() {
    changeVal(0);
  }

  changeVal(int val) {
    if (val < 0) return;
    if (val > 100) return;
    if (val == _val.value) return;
    _val.value = val;
  }
}
