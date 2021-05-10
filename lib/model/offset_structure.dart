import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/rule_instanses.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/game_rules.dart';
import 'package:flutter_checkers/model/offsets.dart';
import 'package:flutter_checkers/util/board.dart';

class OffsetStructure {
  final Offsets movableOffsets;
  final Offsets killOffsets;
  final int jumpOffset;

  OffsetStructure({
    @required this.killOffsets,
    @required this.movableOffsets,
    @required this.jumpOffset,
  });

  OffsetStructure.queen()
      : this.movableOffsets = RuleConstants.offsetsAround,
        this.killOffsets = RuleConstants.offsetsAround,
        this.jumpOffset = BoardUtil.rate;

  OffsetStructure.normal(color)
      : this.movableOffsets = GameRules.offsetsByColor(color),
        this.killOffsets = RuleConstants.offsetsAround,
        this.jumpOffset = 1;
}
