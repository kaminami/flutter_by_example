import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:inifinite_scroll_example/infinite_list_tile.dart';

import 'Infinite_Item.dart';
import 'Infinite_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scroll Grid Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Infinite Scroll Grid Example'),
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
  static const _pageSize = 20;

  final PagingController<int, InfiniteItem> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<InfiniteItem> newItems = await InfiniteRepository().getList(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final int crossAxisCount = max((size.width ~/ 320), 1); // 320はYouTube動画のサムネ幅(mqdefault.jpg)

    print("size: $size, crossAxisCount: $crossAxisCount");

    const double itemAspectRatio = 16 / 10; // Gridアイテムのサイズはアスペクト比の指定で対応する

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          PagedSliverGrid<int, InfiniteItem>(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: itemAspectRatio,
            ),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<InfiniteItem>(
              itemBuilder: (context, item, index) {
                return InfiniteListTile(infiniteItem: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
