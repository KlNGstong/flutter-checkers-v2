import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/model/board.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/checker_generator.dart';
import 'package:flutter_checkers/model/chequers_core.dart';
import 'package:flutter_checkers/model/touch_details.dart';
import 'coord.dart';

class GameController extends ChangeNotifier {
  ChequersCore _core;

  TouchDetails touchDetails = TouchDetails.empty();

  CheckerColor get turnColor => _core.turnColor;
  Board get board => _core.activeBoard;

  void onTapSquare(Coord coord) {
    notifyListeners();
  }

  void onTapActiveSquare(Coord coord) {
    final moveDetails = touchDetails.availableMoves.findDetails(coord);
    final directly = moveDetails.directly(coord);

    _core.processMove(directly);

    if (!_core.isLastCompleted) {
      return onTapChecker(_core.previousChecker);
    }

    touchDetails = TouchDetails.empty();

    notifyListeners();
  }

  void onTapChecker(Checker checker) {
    if (!_core.isTapAvaibleChecker(checker)) return;

    touchDetails.activeChecker = checker;
    touchDetails.availableMoves = _core.safeCalculateAvailableFor(checker);

    notifyListeners();
  }

  GameController.autoFilled() {
    final generated = CheckerGenerator.generateNormal();

    final board = Board.from(generated);
    _core = ChequersCore.forInlineCalculation(board, CheckerColor.white);
  }

  GameController.custom(board) {
    _core = ChequersCore.forInlineCalculation(board, CheckerColor.white);
  }
}
