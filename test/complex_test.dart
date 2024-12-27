import 'package:flutter/material.dart';
import 'package:he/src/taichi/complex.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ComplexTaichi();
  }
}

void main() {
  runApp(const MaterialApp(home: App()));
}
