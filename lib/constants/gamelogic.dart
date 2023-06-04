import 'dart:math';

class GameLogic {
  List<int> sides(int size, int index) {
    List<int> openSides = [];
    int col = index % size;
    int row = (index ~/ size);
    if (row == 0) {
      if (col == 0) {
        openSides.addAll([index + 1, index + size, index + size + 1]);
      } else if (col == size - 1) {
        openSides.addAll([index - 1, index + size, index + size - 1]);
      } else {
        openSides.addAll([
          index + 1,
          index - 1,
          index + size,
          index + size + 1,
          index + size - 1
        ]);
      }
    } else if (row == size - 1) {
      if (col == 0) {
        openSides.addAll([index + 1, index - size, index - size + 1]);
      } else if (col == size - 1) {
        openSides.addAll([index - 1, index - size, index - size - 1]);
      } else {
        openSides.addAll([
          index + 1,
          index - 1,
          index - size,
          index - size + 1,
          index - size - 1
        ]);
      }
    } else {
      if (col == 0) {
        openSides.addAll([
          index + 1,
          index - size,
          index - size + 1,
          index + size,
          index + size + 1
        ]);
      } else if (col == size - 1) {
        openSides.addAll([
          index - 1,
          index - size,
          index - size - 1,
          index + size,
          index + size - 1
        ]);
      } else {
        openSides.addAll([
          index + 1,
          index - 1,
          index - size,
          index - size + 1,
          index - size - 1,
          index + size,
          index + size - 1,
          index + size + 1,
        ]);
      }
    }
    return openSides;
  }

  List<int> setBombs(int size, int bombs) {
    List<int> bombLocations = [];
    for (int i = 0; i < bombs; i++) {
      int random = Random().nextInt(size * size);
      if (bombLocations.contains(random) || random == ((size * size) ~/ 2)) {
        i--;
      } else {
        bombLocations.add(random);
      }
    }
    return (bombLocations);
  }

  List<List> getStatus(int size, List<int> bombs) {
    List<List> status = [];
    for (int i = 0; i < size * size; i++) {
      int nearBombs = 0;
      List<int> openSides = sides(size, i);
      for (int j = 0; j < openSides.length; j++) {
        if (bombs.contains(openSides[j])) {
          nearBombs++;
        }
      }
      status.add([nearBombs, false, false]);
    }
    return (status);
  }

  List<List> revealedTile(int size, List<List> gridStat, int index) {
    List<List> newStats = gridStat;
    if (newStats[index][1] == true) {
      return (newStats);
    } else {
      newStats[index][1] = true;
      if (newStats[index][0] == 0) {
        List openSides = sides(size, index);
        for (int i = 0; i < openSides.length; i++) {
          newStats = revealedTile(size, gridStat, openSides[i]);
        }
      }
    }
    return newStats;
  }

  int countRemaining(List<List> gridStat) {
    int count = 0;
    for (int i = 0; i < gridStat.length; i++) {
      if (gridStat[i][1] == false) {
        count++;
      }
    }
    return (count);
  }
}
