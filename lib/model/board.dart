import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/config/enums/checker_type.dart';

import 'checker.dart';
import 'coord.dart';

class Board {
  List<Checker> white = [];
  List<Checker> black = [];

  bool get isEmpty => chequers.length == 0;
  List<Checker> get chequers => white + black;

  Board.empty();
  Board.cached(this.white, this.black);
  Board.from(List<Checker> chequers) {
    white = _findEveryByColor(chequers, CheckerColor.white);
    black = _findEveryByColor(chequers, CheckerColor.black);
  }

  Board clone() => Board.cached([]..addAll(white), []..addAll(black));

  Checker findByCoord(Coord coord) => chequers
      .firstWhere((checker) => checker.coord == coord, orElse: () => null);
  List<Checker> findEveryByColor(CheckerColor color) =>
      color == CheckerColor.white ? white : black;

  Checker toQueen(Checker checker) => _replaceCheckerWithRemove(
      checker, checker.copyWith(type: CheckerType.queen));

  Checker switchPosition(Checker who, Coord to) =>
      _replaceCheckerWithRemove(who, who.copyWith(coord: to));

  void addChecker(Checker checker) {
    if (checker.color == CheckerColor.white) return white.add(checker);

    return black.add(checker);
  }

  void removeChecker(Checker checker) {
    final filter = (itterable) => itterable.coord == checker.coord;

    if (checker.color == CheckerColor.white) return white.removeWhere(filter);

    return black.removeWhere(filter);
  }

  Checker _replaceCheckerWithRemove(Checker reference, Checker to) {
    removeChecker(reference);

    addChecker(to);

    return to;
  }

  int rateToNextObject(Coord from, Coord direction) =>
      _findRateToNextObject(from, direction);

  int _findRateToNextObject(Coord from, Coord direction, [int rate = 1]) {
    final itterableCoord = from + direction * rate;
    final founded = findByCoord(itterableCoord);

    if (founded != null || itterableCoord.isOverflow) return rate;

    return _findRateToNextObject(from, direction, rate + 1);
  }

  List<Checker> _findEveryByColor(List<Checker> chequers, CheckerColor color) =>
      chequers.where((checker) => checker.color == color).toList();
}
