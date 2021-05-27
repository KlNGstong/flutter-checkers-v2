import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/rule_instanses.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/chequers_core.dart';

class DirectionStructure {
  final List<Coord> movableDirections;
  final List<Coord> killDirections;
  final int lookRate;
  final int jumpRate;

  DirectionStructure({
    @required this.killDirections,
    @required this.movableDirections,
    @required this.lookRate,
    @required this.jumpRate,
  });

  DirectionStructure.queen()
      : this.movableDirections = GameRules.directionsAround,
        this.killDirections = GameRules.directionsAround,
        this.jumpRate = GameRules.jumpRateForQueen,
        this.lookRate = GameRules.lookRateForQueen;

  DirectionStructure.normal(color)
      : this.movableDirections = ChequersCore.directionsByColor(color),
        this.killDirections = GameRules.directionsAround,
        this.jumpRate = GameRules.jumpRateForCommon,
        this.lookRate = GameRules.lookRateForCommon;
}
