import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus_example/connectivity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
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
      home: const MyHomePage(title: 'connectivity_plus Demo'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  ConnectivityResult? resultByButton;

  StreamSubscription<ConnectivityResult>? subscription;
  ConnectivityResult? resultByListener;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        print("$runtimeType, onConnectivityChanged, $result");
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
    final AsyncValue<ConnectivityResult> resultByProvider = ref.watch(connectivityStateProvider);

    final resultByNotifierView = resultByProvider.when(
      data: (res) {
        return Text("update by provider: $res");
      },
      error: (error, stacktrace) => Text(error.toString()),
      loading: CircularProgressIndicator.new,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            resultByNotifierView,
            const SizedBox(height: 30),
            Text("update by listener: $resultByListener"),
            const SizedBox(height: 30),
            Text("update by button pressed: ${resultByButton ?? 'N/A'}"),
            FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () async {
                final res = await Connectivity().checkConnectivity();

                setState(() {
                  print("$runtimeType, FloatingActionButton.onPressed, $res");
                  resultByButton = res;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
