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
      title: 'StarMenu Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'StarMenu Example'),
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
    StarMenuController menuController = StarMenuController();

    List<Widget> menuItems = const [
      FloatingActionButton(backgroundColor: Colors.blue, onPressed: null, child: Icon(Icons.add_call)),
      FloatingActionButton(backgroundColor: Colors.green, onPressed: null, child: Icon(Icons.adb)),
      FloatingActionButton(backgroundColor: Colors.purple, onPressed: null, child: Icon(Icons.home)),
      FloatingActionButton(backgroundColor: Colors.brown, onPressed: null, child: Icon(Icons.delete)),
      FloatingActionButton(backgroundColor: Colors.deepOrange, onPressed: null, child: Icon(Icons.get_app)),
    ];

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
      ).addStarMenu(
        items: menuItems,
        params: const StarMenuParameters(
          useLongPress: false,
          useTouchAsCenter: true,
        ),
        controller: menuController,
        onItemTapped: (index, controller) {
          final selectedMenuItem = menuItems[index] as FloatingActionButton;
          _showMessage("${widget.name}, menu index:$index, ", selectedMenuItem.backgroundColor!, context);
        },
      ),
    );
  }

  void _showMessage(String message, Color backgroundColor, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: backgroundColor,
        content: Text(message),
      ),
    );
  }
}
