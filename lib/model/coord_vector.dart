import 'package:flutter_checkers/model/coord.dart';

class CoordVector {
  final Coord offset;
  final Coord startPoint;
  final int rate;

  bool cross(Coord coord) {
    final dif = coord.index - startPoint.index;

    if (dif % offset.index != 0) return false;

    final devided = dif / offset.index;

    return devided <= rate && devided > 0;
  }

  Coord get endPoint => startPoint + offset * rate;
  bool get isNull => rate <= 0;

  CoordVector(
    this.startPoint,
    this.offset, [
    this.rate = 0,
  ]);
}
