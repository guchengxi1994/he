import 'package:flutter/material.dart';
import 'package:he/he.dart';
import 'package:he/src/taichi/eight_trigrams.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 800,
        height: 800,
        child: CustomPaint(
          painter: EightTrigrams(),
          child: Center(
            child: Taichi.basic(size: 400),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: App()));
}
