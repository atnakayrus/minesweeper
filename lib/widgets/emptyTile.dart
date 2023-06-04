import 'package:flutter/material.dart';
import 'package:minesweeper/constants/appStyle.dart';

class EmptyTile extends StatelessWidget {
  final int near;
  final bool status;
  final bool flagged;
  final void Function()? onTap;
  final void Function()? onLongPress;
  const EmptyTile(
      {super.key,
      required this.near,
      required this.status,
      required this.onTap,
      required this.flagged,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    Text styledText(int n) {
      if (n == 0) {
        return const Text('');
      } else if (n == 1) {
        return const Text('1',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green));
      } else if (n == 2) {
        return const Text('2',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue));
      } else {
        return Text(n.toString(),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red));
      }
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: status ? AppStyle.tileInactiveColor : AppStyle.tileActiveColor,
        child: status
            ? Center(child: styledText(near))
            : flagged
                ? Icon(Icons.flag)
                : null,
      ),
    );
  }
}
