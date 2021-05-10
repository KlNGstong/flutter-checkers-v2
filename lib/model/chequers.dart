import 'package:flutter_checkers/config/enums/checker_color.dart';

import 'checker.dart';
import 'coord.dart';

class Chequers {
  final List<Checker> list;

  Chequers.from(List<Checker> list) : this.list = list;
  Chequers.empty() : this.list = [];

  Checker findByCoord(Coord coord) =>
      list.firstWhere((checker) => checker.coord == coord, orElse: () => null);

  List<Checker> findEveryByColor(CheckerColor color) => !isEmpty
      ? list.where((checker) => checker.color == color).toList()
      : null;

  Chequers addChecker(Checker checker) {
    final addedList = clone().list..add(checker);

    return Chequers.from(addedList);
  }

  Chequers removeChecker(Checker checker) {
    final removedList = clone().list
      ..removeWhere((itterable) => itterable.coord == checker.coord);

    return Chequers.from(removedList);
  }

  bool get isEmpty => list.length == 0;

  Chequers clone() => Chequers.from([]..addAll(list));
}
