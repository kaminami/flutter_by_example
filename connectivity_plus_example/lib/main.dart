import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'connectivity_plus Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'connectivity_plus Demo'),
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
  ConnectivityResult? resultByButton;

  StreamSubscription<ConnectivityResult>? subscription;
  ConnectivityResult? resultByListener;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('onConnectivityChanged');

      setState(() {
        resultByListener = result;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "update by listener: $resultByListener"
            ),
            const SizedBox(height: 30),
            Text(
              "update by button pressed: ${resultByButton ?? 'N/A'}"
            ),
            FloatingActionButton(
              child: const Icon(Icons.refresh),
                onPressed: () async {
                  final res = await Connectivity().checkConnectivity();

                  setState(() {
                    resultByButton = res;
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
