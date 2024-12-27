import 'package:flutter/material.dart';
import 'package:he/src/taichi/basic.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicTaichi();
  }
}

void main() {
  runApp(const MaterialApp(home: App()));
}
