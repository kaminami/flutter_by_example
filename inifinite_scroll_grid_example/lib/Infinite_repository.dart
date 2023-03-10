import 'package:inifinite_scroll_example/Infinite_Item.dart';

class InfiniteRepository {
  static final InfiniteRepository _instance = InfiniteRepository._internal();
  factory InfiniteRepository() => _instance;
  InfiniteRepository._internal();

  Future<List<InfiniteItem>> getList(int pageKey, int pageSize) async {
    await Future.delayed(const Duration(seconds: 2));

    final items = <InfiniteItem>[];

    for (int i = 0; i < pageSize; i++) {
      final id = pageKey + i;

      items.add(
        InfiniteItem(
          id: id,
          label: 'Hello, $id',
        ),
      );
    }

    return items;
  }
}
