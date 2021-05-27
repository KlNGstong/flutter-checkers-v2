import 'package:flutter_checkers/model/coord.dart';

class CoordVector {
  final Coord direction;
  final Coord startPoint;
  final int rate;

  bool totalCrossedBy(Coord coord) {
    final dif = coord.index - startPoint.index;

    if (dif % direction.index != 0) return false;

    final devided = dif / direction.index;

    return devided <= rate && devided >= 0;
  }

  bool crossedBy(Coord coord) {
    final dif = coord.index - startPoint.index;

    if (dif % direction.index != 0) return false;

    final devided = dif / direction.index;

    return devided <= rate && devided > 0;
  }

  Coord get endPoint => startPoint + direction * rate;
  bool get isNone => rate <= 0;

  CoordVector(
    this.startPoint,
    this.direction, [
    this.rate = 0,
  ]);
}
