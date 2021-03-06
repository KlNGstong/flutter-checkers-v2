import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/config/enums/checker_type.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/direction_structure.dart';

class Checker {
  final CheckerColor color;
  CheckerType type;
  Coord coord;

  DirectionStructure get directionStructure => type == CheckerType.queen
      ? DirectionStructure.queen()
      : DirectionStructure.normal(color);

  bool isColorReversed(Checker checker) => checker.color != color;

  Checker.queen(this.coord, this.color) : this.type = CheckerType.queen;

  Checker.common(this.coord, this.color) : this.type = CheckerType.common;

  Checker.custom({this.coord, this.color, this.type});

  void jumpTo(Coord coord) => this.coord = coord;
  void toQueen() => type = CheckerType.queen;

  Checker copyWith({Coord coord, CheckerType type, CheckerColor color}) =>
      Checker.custom(
        coord: coord ?? this.coord,
        color: color ?? this.color,
        type: type ?? this.type,
      );

  @override
  bool operator ==(Object object) => object is Checker && object.coord == coord;

  @override
  int get hashCode => coord.index;
}
