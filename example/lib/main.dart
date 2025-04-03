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
    debugPrint("paint once");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SimpleLayout(items: [
        SidebarItem(
          icon: const Icon(Icons.dataset, color: Colors.blueAccent),
          iconInactive: const Icon(Icons.dataset),
          index: 0,
          title: "Taichi",
        ),
        SidebarItem(
          icon: const Icon(Icons.rule, color: Colors.blueAccent),
          iconInactive: const Icon(Icons.rule),
          index: 1,
          title: "Others",
        ),
        SidebarItem(
          icon: const Icon(Icons.text_fields, color: Colors.blueAccent),
          iconInactive: const Icon(Icons.text_fields),
          index: 2,
          title: "Tiles",
        ),
      ], children: [
        _taichi(),
        _others(),
        _tiles()
      ]),
    );
  }

  Widget _wrapper(String text, Widget child) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Column(
        spacing: 20,
        children: [
          Text(text),
          child,
        ],
      ),
    );
  }

  Widget _taichi() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _wrapper("1. Taichi basic", Taichi.basic()),
        _wrapper("2. Taichi complex", Taichi.complex(size: 200)),
        _wrapper("3. Taichi paint basic", Taichi.paintBasic()),
        _wrapper("4. Taichi progress bar(left to right)",
            TaichiProgressBar(controller: _controller)),
        _wrapper("5. Taichi progress bar(middle to side)",
            TaichiProgressBar2(controller: _controller)),
        _wrapper("6. Bagua", EightTrigrams(size: 300)),
        _wrapper("7. Animated bagua", AnimatedEightTrigrams(size: 300)),
      ],
    );
  }

  Widget _others() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _wrapper(
            "8. Code rain",
            CodeRain(
              controller: CodeRainController(count: 5, stringLength: 7),
            )),
        _wrapper(
            "8. Tear text",
            TearText(
              fontSize: 48,
              controller: TearTextController(
                origin: "I love flutter",
                target: " I love China ",
              ),
            )),
        _wrapper("9. Star map", StarMap(viewWindowWidth: 400)),
      ],
    );
  }

  Widget _tiles() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _wrapper(
            "10. animated tile",
            AnimatedTile(
              onTap: () {
                debugPrint("clicked");
              },
              title: 'Test tile',
              description: 'This is a test tile',
              width: 300,
              height: 200,
              color: Colors.blue,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}
