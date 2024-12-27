import 'dart:async';

import 'package:flutter/material.dart';
import 'package:he/he.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoadingController _controller = LoadingController();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      _controller.changeVal(_controller.value.value + 1);
      if (_controller.value.value >= 100) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Taichi basic"),
              Taichi.basic(),
              Text("Taichi complex"),
              Taichi.complex(),
              Text("Taichi paint basic"),
              Taichi.paintBasic(),
              Text("Taichi progress bar"),
              TaichiProgressBar(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
