import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/util/board.dart';

import 'checker.dart';
import 'coord.dart';

class CheckerGenerator {
  static List<Checker> generateNormal() {
    List<Checker> result = [];

    List.generate(
        BoardUtil.rate,
        (column) => List.generate(BoardUtil.rate, (row) {
              final coord = Coord(row, column);

              final isWhiteChecker = column > BoardUtil.rate - 4;
              final isBlackChecker = column < 3;

              if (!coord.isWhite && (isWhiteChecker || isBlackChecker)) {
                CheckerColor color =
                    isWhiteChecker ? CheckerColor.white : CheckerColor.black;

                result.add(Checker.common(coord, color));
              }
            }));
    return result;
  }
}
