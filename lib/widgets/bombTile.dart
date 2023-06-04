import 'package:flutter/material.dart';

import '../constants/appStyle.dart';

class BombTile extends StatelessWidget {
  final bool revealed;
  final bool flagged;
  final void Function()? onTap;
  final void Function()? onLongPress;
  const BombTile(
      {super.key,
      required this.revealed,
      required this.onTap,
      required this.flagged,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: revealed ? Colors.red : AppStyle.tileActiveColor,
        child: flagged ? Icon(Icons.flag) : null,
      ),
    );
  }
}
