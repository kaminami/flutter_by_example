import 'package:flutter/material.dart';
import 'package:inifinite_scroll_example/Infinite_Item.dart';

class InfiniteListTile extends StatelessWidget {
  final InfiniteItem infiniteItem;

  const InfiniteListTile({super.key, required this.infiniteItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(infiniteItem.label),
    );
  }
  
}