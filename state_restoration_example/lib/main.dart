import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_restoration_example/counter_state.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

Future<void> main() async {
  print("### main");

  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences sharedPreferences;
  await Future.wait([
    Future(() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }),
  ]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Restoration Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'State Restoration Example'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final counterVal = ref.read(sharedPreferencesProvider).getInt('counter');
      ref.read(counterStateProvider.notifier).state = counterVal ?? 0;
    });

    print("### initState");
  }

  @override
  void dispose() {
    print("### dispose");

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterStateProvider.notifier).increment();

          final int countVal = ref.read(counterStateProvider.notifier).state;
          ref.read(sharedPreferencesProvider).setInt('counter', countVal);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("### $state");
  }
}
