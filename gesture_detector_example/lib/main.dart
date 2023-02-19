import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestureDetector Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GestureDetector Test'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _Canvas(),
    );
  }
}

class _Canvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _GestureObject(name: 'circle', initialPosition: Offset(100, 100), iconData: Icons.circle),
        _GestureObject(name: 'circle_outlined', initialPosition: Offset(150, 100), iconData: Icons.circle_outlined),
        _GestureObject(name: 'account_circle', initialPosition: Offset(200, 100), iconData: Icons.account_circle),
        _GestureObject(initialPosition: Offset(200, 200), iconData: Icons.yard),
      ],
    );
  }
}

class _GestureObject extends StatefulWidget {
  final Offset initialPosition;
  final IconData iconData;
  final String? name;

  const _GestureObject({required this.initialPosition, required this.iconData, this.name});

  @override
  State<_GestureObject> createState() => _GestureObjectState();
}

class _GestureObjectState extends State<_GestureObject> {
  late Offset position;
  late Icon icon;
  late String name;

  @override
  void initState() {
    super.initState();

    position = widget.initialPosition;
    icon = Icon(widget.iconData, size: 40);
    name = widget.name ?? icon.icon.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          print('tapped: $name');
        },
        onDoubleTap: () {
          print('doubleTapped: $name');
        },
        onLongPress: () {
          print('longPress: $name');
        },
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            position += details.delta;
          });
        },
        child: icon,
      ),
    );
  }
}
