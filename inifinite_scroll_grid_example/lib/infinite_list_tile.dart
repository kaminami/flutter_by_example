import 'package:flutter/material.dart';
import 'package:inifinite_scroll_example/Infinite_Item.dart';

class InfiniteListTile extends StatelessWidget {
  final InfiniteItem infiniteItem;

  const InfiniteListTile({super.key, required this.infiniteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Icon(Icons.account_circle),
          Text(
            "ID: ${infiniteItem.id}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            infiniteItem.label,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
