import 'package:flutter/material.dart';

class LayoutNotifier extends ValueNotifier<int> {
  LayoutNotifier(super.value);

  late final PageController controller = PageController();

  void change(int v) {
    if (value == v) return;
    value = v;
    notifyListeners();
    controller.animateToPage(
      v,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
