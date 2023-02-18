import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'youtube_player_iframe test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'youtube_player_iframe test'),
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
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'joXAMsm9u7k', // https://www.youtube.com/watch?v=joXAMsm9u7k&t=5s
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
      final shouldShowAppBar = orientation == Orientation.portrait;

      return Scaffold(
        appBar: shouldShowAppBar ? AppBar(title: Text(widget.title)) : null,
        body: YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return Column(
              children: [
                player,
              ],
            );
          },
        ),
      );
    });
  }
}
