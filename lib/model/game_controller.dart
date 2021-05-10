import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/model/available_moves.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/checker_generator.dart';
import 'package:flutter_checkers/model/chequers.dart';
import 'package:flutter_checkers/model/game_rules.dart';
import 'package:flutter_checkers/model/touch_details.dart';

import 'coord.dart';

class GameController extends ChangeNotifier {
  Chequers chequers;
  CheckerColor turnColor = CheckerColor.white;
  TouchDetails touchDetails = TouchDetails.empty();

  void onTapSquare(Coord coord) {
    final rules = GameRules.forInlineCalculation(chequers, turnColor);
    final checker = chequers.findByCoord(coord);

    if (checker != null) {
      touchDetails.activeChecker = checker;
      touchDetails.moves =
          AvailableMoves.from(rules.findPeacefulMoves(checker));

      // print(rules.findCheckerOnTheWay(checker, Coord(1, -1)));
    } else if (touchDetails.activeChecker != null) {
      touchDetails = TouchDetails.empty();
    } else
      touchDetails.touched = coord;

    notifyListeners();
  }

  void onGameEnd() {}

  GameController.autoFilled() {
    final generated = CheckerGenerator.generateNormal();

    chequers = Chequers.from(generated);
  }

  GameController.custom(this.chequers);
}
