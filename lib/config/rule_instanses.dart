import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/coord_vector.dart';
import 'package:flutter_checkers/util/board.dart';

class GameRules {
  static final List<Coord> directionsAround = [
    ...directionsForWhite,
    ...directionsForBlack
  ];

  static final List<Coord> directionsForWhite = [
    Coord(1, -2),
    Coord(-1, -2),
    Coord(-2, 1),
    Coord(2, 1)
  ];

  static final List<Coord> directionsForBlack = [
    Coord(1, 2),
    Coord(-1, 2),
    Coord(-2, -1),
    Coord(2, -1)
  ];

  static final int lookRateForQueen = BoardUtil.rate;
  static final int jumpRateForQueen = BoardUtil.rate;

  static final int lookRateForCommon = 2;
  static final int jumpRateForCommon = 1;

  static final CoordVector vectorToEndentifyBlackQueen =
      CoordVector(lowerBoardCoord, Coord(1, 0), BoardUtil.rate);
  static final CoordVector vectorToEndentifyWhiteQueen =
      CoordVector(upperBoardCoord, Coord(1, 0), BoardUtil.rate);

  static final lowerBoardCoord = Coord.zero;
  static final upperBoardCoord = Coord(0, BoardUtil.rate);
}
