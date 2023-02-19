import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomPopupMenu  Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CustomPopupMenu  Test'),
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
        _DraggableObject(initialPosition: Offset(100, 100), iconData: Icons.circle),
        _DraggableObject(initialPosition: Offset(150, 100), iconData: Icons.circle_notifications_outlined),
        _DraggableObject(initialPosition: Offset(200, 100), iconData: Icons.account_circle),
      ],
    );
  }
}

class _DraggableObject extends StatefulWidget {
  final Offset initialPosition;
  final IconData iconData;

  const _DraggableObject({required this.initialPosition, required this.iconData});

  @override
  State<_DraggableObject> createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<_DraggableObject> {
  late Offset position;
  late Icon icon;

  @override
  void initState() {
    super.initState();

    position = widget.initialPosition;
    icon = Icon(widget.iconData, size: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        childWhenDragging: Container(),
        onDragEnd: (DraggableDetails details) {
          setState(() {
            final renderBox = context.findAncestorRenderObjectOfType() as RenderBox;
            final localOffset = renderBox.globalToLocal(details.offset);

            position = localOffset;
          });
        },
        feedback: icon,
        child: icon,
      ),
    );
  }
}
