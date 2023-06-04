import 'package:flutter/material.dart';

import '../constants/appStyle.dart';

class BombTile extends StatelessWidget {
  final bool revealed;
  final void Function()? onTap;
  const BombTile({super.key, required this.revealed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: revealed ? Colors.red : AppStyle.tileActiveColor,
      ),
    );
  }
}
