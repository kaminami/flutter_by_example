import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previous State Image Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Previous State Image Example'),
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
  Widget backgroundImage = Image.asset('assets/images/blank.png'); // RawImageと差し替えるので、Widgetクラスで受ける

  final GlobalKey canvasBoundaryKey = GlobalKey();
  late Widget canvasBoundary;

  @override
  void initState() {
    super.initState();

    canvasBoundary = RepaintBoundary(
      key: canvasBoundaryKey,
      child: _Canvas(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.topCenter,
            // color: Colors.lightGreen,
            child: Opacity(
              opacity: 0.3,
              child: backgroundImage,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: canvasBoundary,
          ),
          FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.camera_alt_outlined),
              onPressed: () {
                setState(() {
                  updateCanvasBackground();
                });
              }),
        ],
      ),
    );
  }

  void updateCanvasBackground() {
    RenderRepaintBoundary boundary = canvasBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final snapshot = boundary.toImageSync();

    backgroundImage = RawImage(image: snapshot);
  }
}

class _Canvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _DraggableObject(name: 'Account', initialPosition: Offset(200, 100), iconData: Icons.account_circle),
        _DraggableObject(name: 'Balance', initialPosition: Offset(100, 100), iconData: Icons.balance),
        _DraggableObject(name: 'Clock', initialPosition: Offset(150, 100), iconData: Icons.lock_clock),
      ],
    );
  }
}

class _DraggableObject extends StatefulWidget {
  final Offset initialPosition;
  final IconData iconData;
  final String name;

  const _DraggableObject({required this.initialPosition, required this.iconData, required this.name});

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
