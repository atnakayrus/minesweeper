import 'package:flutter/material.dart';
import 'package:minesweeper/constants/appStyle.dart';

Widget Victory(BuildContext context, void Function() restart) {
  return AlertDialog(
    title: Center(
        child: Text(
      'Y O U W I N !',
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: AppStyle.mainColor),
    )),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('View Board'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              restart();
            },
            child: const Text('Play again'),
          ),
        ],
      )
    ],
  );
}

Widget Loss(BuildContext context, void Function() restart) {
  return AlertDialog(
    title: Center(
        child: Text(
      'Y O U L O S E !',
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: AppStyle.mainColor),
    )),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('View Board'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              restart();
            },
            child: const Text('Play again'),
          ),
        ],
      )
    ],
  );
}
