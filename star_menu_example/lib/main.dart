import 'package:flutter/material.dart';
import 'package:star_menu/star_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarMenu Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'StarMenu Test'),
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
        _DraggableObject(name: 'circle', initialPosition: Offset(100, 100), iconData: Icons.circle),
        _DraggableObject(name: 'circle_notifications_outlined', initialPosition: Offset(150, 100), iconData: Icons.circle_notifications_outlined),
        _DraggableObject(name: 'account_circle', initialPosition: Offset(200, 100), iconData: Icons.account_circle),
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

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    StarMenuController menuController = StarMenuController();

    List<Widget> menuItems = [
      FloatingActionButton(
        onPressed: () {
          _showMessage('tapped: "add_call" menu, target: ${widget.name}', context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add_call),
      ),
      FloatingActionButton(
        onPressed: () {
          _showMessage('tapped: "adb menu", target: ${widget.name}', context);
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.adb),
      ),
      FloatingActionButton(
        onPressed: () {
          _showMessage('tapped: "home menu", target: ${widget.name}', context);
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.home),
      ),
      FloatingActionButton(
        onPressed: () {
          _showMessage('tapped: "delete" menu, target: ${widget.name}', context);
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.delete),
      ),
      FloatingActionButton(
        onPressed: () {
          _showMessage('tapped: "get_app" menu, target: ${widget.name}', context);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.get_app),
      ),
    ];

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: StarMenu(
          params: const StarMenuParameters(
            useLongPress: false,
            useTouchAsCenter: true,
          ),
          controller: menuController,
          items: menuItems,
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
          )),
    );
  }
}
