import 'package:flutter/material.dart';
import 'package:minesweeper/constants/appStyle.dart';
import 'package:minesweeper/constants/gamelogic.dart';
import 'package:minesweeper/widgets/bombTile.dart';
import 'package:minesweeper/widgets/emptyTile.dart';
import 'package:minesweeper/widgets/endScreens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int size = 9;
  int bombs = 16;
  int remaining = 81;
  List<List> gridStat = [];
  List<int> bombLocation = [];
  GameLogic gl = GameLogic();
  bool revealed = false;
  gameStart() {
    bombLocation = gl.setBombs(size, bombs);
    gridStat = gl.getStatus(size, bombLocation);
    setState(() {
      revealed = false;
    });
    remaining = size * size;
  }

  @override
  void initState() {
    gameStart();
    remaining = size * size;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: Column(children: [
        //game stats and menu

        Container(
          height: 150,
          color: AppStyle.accentColor,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bombs.toString(),
                        style: AppStyle.mainText,
                      ),
                      Text(
                        'B O M B S',
                        style: AppStyle.mainText,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gameStart();
                      });
                    },
                    child: Card(
                      color: AppStyle.mainColor,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 40,
                        weight: 50,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        remaining.toString(),
                        style: AppStyle.mainText,
                      ),
                      Text(
                        'REMAINING',
                        style: AppStyle.mainText,
                      )
                    ],
                  ),
                ]),
          ),
        ),

        // grid of game
        Expanded(
            child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: AppStyle.gameColor,
            child: GridView.builder(
                itemCount: size * size,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(2),
                      child: bombLocation.contains(index)
                          ? BombTile(
                              revealed: revealed,
                              onTap: revealed
                                  ? () {}
                                  : () {
                                      setState(() {
                                        revealed = true;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              Loss(context, gameStart));
                                    })
                          : EmptyTile(
                              near: gridStat[index][0],
                              status: gridStat[index][1],
                              onTap: revealed
                                  ? () {}
                                  : () {
                                      var newstats = gl.revealedTile(
                                          size, gridStat, index);
                                      setState(() {
                                        remaining = gl.countRemaining(gridStat);
                                        gridStat = newstats;
                                      });
                                      if (remaining == bombs) {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                Victory(context, gameStart));
                                      }
                                    }));
                }),
          ),
        )),

        //difficulties
        Container(
          color: AppStyle.accentColor,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    size = 7;
                    bombs = 9;
                    setState(() {
                      gameStart();
                    });
                  },
                  child: Text(
                    'EASY',
                    style: AppStyle.mainText,
                  )),
              TextButton(
                  onPressed: () {
                    size = 9;
                    bombs = 16;
                    setState(() {
                      gameStart();
                    });
                  },
                  child: Text(
                    'NORMAL',
                    style: AppStyle.mainText,
                  )),
              TextButton(
                onPressed: () {
                  size = 11;
                  bombs = 36;
                  setState(() {
                    gameStart();
                  });
                },
                child: Text(
                  'HARD',
                  style: AppStyle.mainText,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
