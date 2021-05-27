import 'dart:math';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/config/rule_instanses.dart';
import 'package:flutter_checkers/model/available_moves.dart';
import 'package:flutter_checkers/model/board.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/coord_vector.dart';
import 'package:flutter_checkers/model/move_details.dart';
import 'package:flutter_checkers/util/board.dart';

class ChequersCore {
  Board activeBoard;
  Checker previousChecker;
  CheckerColor turnColor;

  ChequersCore.forRecursionCalculation(Board board)
      : this.activeBoard = board.clone();
  ChequersCore.forInlineCalculation(this.activeBoard, this.turnColor);

  bool get isLastCompleted =>
      previousChecker == null ||
      previousChecker.color != turnColor ||
      !isAngureChecker(previousChecker);

  static CoordVector queenVectorByColor(CheckerColor color) {
    if (color == CheckerColor.black)
      return GameRules.vectorToEndentifyBlackQueen;

    return GameRules.vectorToEndentifyWhiteQueen;
  }

  static bool isQueen(Checker checker) {
    final vector = queenVectorByColor(checker.color);

    return vector.crossedBy(checker.coord);
  }

  static List<Coord> directionsByColor(CheckerColor color) =>
      color == CheckerColor.white
          ? GameRules.directionsForWhite
          : GameRules.directionsForBlack;

  bool isThereAngure(CheckerColor color) =>
      _findFirstAngureCheckerFor(color) != null;
  bool isAngureChecker(Checker checker) => _findAngryMoves(checker).isNotEmpty;

  bool isTapAvaibleChecker(Checker checker) {
    if (checker.color != turnColor) return false;

    if (isLastCompleted) return true;

    return previousChecker == checker;
  }

  void swapTrunColor() {
    final nextColor = turnColor == CheckerColor.white
        ? CheckerColor.black
        : CheckerColor.white;

    turnColor = nextColor;
  }

  void processMove(DirectlyMove move) {
    if (move.isAngureMove) activeBoard.removeChecker(move.destroyedChecker);

    final checker =
        activeBoard.switchPosition(move.activeChecker, move.endPoint);

    previousChecker = checker;

    if (isQueen(checker)) checker.toQueen();

    if (isLastCompleted || move.isPeacefulMove) swapTrunColor();
  }

  AvailableMoves safeCalculateAvailableFor(Checker checker) {
    if (isLastCompleted) return forceCalculeAvailableFor(checker);

    if (checker == previousChecker) {
      final angryMoves = _findAngryMoves(checker);

      return AvailableMoves.from(angryMoves);
    }

    return AvailableMoves.empty();
  }

  AvailableMoves forceCalculeAvailableFor(Checker checker) {
    List<MoveDetails> listDetails = [];

    if (isThereAngure(checker.color))
      listDetails.addAll(_findAngryMoves(checker));
    else
      listDetails.addAll(_findPeacefulMoves(checker));

    return AvailableMoves.from(listDetails);
  }

  List<MoveDetails> _findPeacefulMoves(Checker checker) {
    return checker.directionStructure.movableDirections.fold(<MoveDetails>[],
        (list, direction) {
      final details = _findDirectlyCheckerMove(checker, direction);

      if (details.isAngureMove || details.isNone) return list;

      return [...list, details];
    });
  }

  List<MoveDetails> _findAngryMoves(Checker checker) {
    return checker.directionStructure.killDirections.fold(<MoveDetails>[],
        (list, direction) {
      final details = _findDirectlyCheckerMove(checker, direction);

      if (details.isPeacefulMove || details.isNone) return list;

      return [...list, details];
    });
  }

  Checker _findFirstAngureCheckerFor(CheckerColor color) {
    for (var checker in activeBoard.findEveryByColor(color)) {
      final isAngure = isAngureChecker(checker);

      if (isAngure) return checker;
    }

    return null;
  }

  MoveDetails _findDirectlyCheckerMove(Checker checker, Coord direction) {
    MoveDetails info = MoveDetails(activeChecker: checker);

    final maxJumpRate = checker.directionStructure.jumpRate;

    final closestObjectRate =
        activeBoard.rateToNextObject(checker.coord, direction);

    if (closestObjectRate > maxJumpRate)
      return info..vector = CoordVector(checker.coord, direction, maxJumpRate);

    final closestObjectCoord = checker.coord + direction * closestObjectRate;
    final closestChecker = activeBoard.findByCoord(closestObjectCoord);

    final farestObjectRate =
        activeBoard.rateToNextObject(closestObjectCoord, direction);

    final isAngure = closestChecker != null &&
        closestChecker.color != checker.color &&
        farestObjectRate - 1 > 0;

    if (isAngure) {
      final remaningJumpRate =
          checker.directionStructure.lookRate - closestObjectRate;
      final availableRate = min(farestObjectRate - 1, remaningJumpRate);

      return info
        ..destroyedChecker = closestChecker
        ..vector = CoordVector(closestObjectCoord, direction, availableRate);
    }

    return info
      ..vector = CoordVector(checker.coord, direction, closestObjectRate - 1);
  }
}
