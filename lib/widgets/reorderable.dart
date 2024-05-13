import 'package:flutter/material.dart';

class ReorderableItem extends StatelessWidget {
  final Key key;
  final Widget child;
  final Function(ReorderableItem) onReorder;

  ReorderableItem({
    required this.key,
    required this.child,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onPanUpdate: (details) {
        if (onReorder != null) {
          onReorder(this);
        }
      },
      child: child,
    );
  }
}