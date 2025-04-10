import 'dart:async';
import 'dart:convert';

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
      body: SimpleLayout(
          elevation: 10,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          items: [
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
            SidebarItem(
              icon: const Icon(Icons.forum, color: Colors.blueAccent),
              iconInactive: const Icon(Icons.forum),
              index: 3,
              title: "Forms",
            ),
          ],
          children: [
            _taichi(),
            _others(),
            _tiles(),
            _form()
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
    return SingleChildScrollView(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _wrapper("Taichi basic", Taichi.basic()),
          _wrapper("Taichi complex", Taichi.complex(size: 200)),
          _wrapper("Taichi paint basic", Taichi.paintBasic()),
          _wrapper("Taichi progress bar(left to right)",
              TaichiProgressBar(controller: _controller)),
          _wrapper("Taichi progress bar(middle to side)",
              TaichiProgressBar2(controller: _controller)),
          _wrapper("Bagua", EightTrigrams(size: 300)),
          _wrapper("Animated bagua", AnimatedEightTrigrams(size: 300)),
        ],
      ),
    );
  }

  Widget _others() {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _wrapper(
              "Code rain",
              CodeRain(
                controller: CodeRainController(count: 5, stringLength: 7),
              )),
          _wrapper(
              "Tear text",
              TearText(
                fontSize: 48,
                controller: TearTextController(
                  origin: "I love flutter",
                  target: " I love China ",
                ),
              )),
          _wrapper("Star map", StarMap(viewWindowWidth: 400)),
        ],
      ),
    );
  }

  Widget _tiles() {
    return SingleChildScrollView(
      child: Wrap(
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
      ),
    );
  }

  Widget _form() {
    final testJson = """
{
    "form-name": "form name or null",
    "width": 400,
    "height": 600,
    "items": [
        {
            "type": "title",
            "style": "size:16;bold:true;color:#000000",
            "text": "title name",
            "align": "center",
            "children": [],
            "uniqueId": null
        },
        {
            "type": "text",
            "style": "size:14;bold:true;color:#FF0000",
            "text": "text name",
            "align": "left",
            "children": [],
            "uniqueId": null
        },
        {
            "type": "input",
            "style": null,
            "text": "hint text",
            "align": null,
            "children": [],
            "uniqueId": "input 1"
        },
        {
            "type": "dropdown",
            "style": null,
            "text": "item1;item2;item3",
            "align": null,
            "children": [],
            "uniqueId": "dropdown 1"
        },
        {
            "type": "row",
            "style": null,
            "text": null,
            "align": null,
            "uniqueId": null,
            "children": [
                {
                    "type": "text",
                    "style": "size:14;bold:true;color:#000000",
                    "text": "text name",
                    "align": "left",
                    "children": [],
                    "uniqueId": null
                },
                {
                    "type": "input",
                    "style": null,
                    "text": "hint text",
                    "align": null,
                    "children": [],
                    "uniqueId": "input 2"
                }
            ]
        }
    ]
}

""";

    final jsonModel = FormModel.fromJson(jsonDecode(testJson));

    return Center(
      child: JsonForm(
          model: jsonModel,
          onSubmit: (m) {
            debugPrint(m.toString());
          }),
    );
  }
}
