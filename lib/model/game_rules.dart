import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/config/enums/checker_type.dart';
import 'package:flutter_checkers/config/errors/game_rule.dart';
import 'package:flutter_checkers/config/rule_instanses.dart';
import 'package:flutter_checkers/model/available_moves.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/chequers.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/coord_vector.dart';
import 'package:flutter_checkers/model/move_details.dart';
import 'package:flutter_checkers/model/offsets.dart';
import 'package:flutter_checkers/util/board.dart';

class GameRules {
  Chequers _chequers;
  Checker _checker;
  CheckerColor _turnColor;

  /// It can be used for func that do not depend of the [Chequers].
  GameRules.fromChecker(Checker checker) : this._checker = checker;

  /// `InlineCalculation` should be used for async game proccess calculations
  // ? Difference
  ///     [isThereAngrueCheckers] is calculated on the constructor step

  GameRules.forInlineCalculation(Chequers chequers, this._turnColor)
      : this._chequers = chequers {
    // this.isThereAngrueCheckers = _findFirstAngryChecker(color) == null;
  }

  /// `RecursionCalculation` should be used for gameRule methods that are worked in recursion way
  // ? Difference
  ///     [isThereAngrueCheckers] is not calculated
  ///      Optimal for [MovePice] calculations

  GameRules.forRecursionCalculation(Chequers chequers)
      : this._chequers = chequers.clone();

  AvailableMoves calculateAvaliableMoves() {
    return AvailableMoves.empty();
  }

  bool isThereAngrueCheckers = false;

  /// Optimize func for setting [isThereAngrueCheckers] property
  /// the func calculate [MoveDetails] instead [MovePiece]
  // ! Returns
  ///   [null] if there are not any angry checkers
  ///   [Checker] if there is angry checker
  Checker _findFirstAngryChecker(CheckerColor color) {
    for (var checker in _chequers.findEveryByColor(color)) {
      final available = findAngryMoves(checker);

      if (available.isEmpty) continue;

      return checker;
    }

    return null;
  }

  /// As far there are two [objects] in the programm: `checker`, `end of board`
  /// Provided for `kill calculations` - if [_findRateToNextObject] is null there are not any avaliable checkers to kill on the way
  // ! Returns
  ///   [null] if limit of checker jump exceeded
  ///   [rate to checker] if there is some checker on the way
  ///   [rate to end of board] if there aren't any checkers on the way
  ///   `maxed` - `true` returns previous rate instead of null. Provided for different kinds of search func
  int _findRateToNextObject(Coord from, Coord offset, int jumpOffset,
      [int rate = 1]) {
    if (rate > jumpOffset) return jumpOffset;

    final itterableCoord = from + offset * rate;
    final founded = _chequers.findByCoord(itterableCoord);

    if (founded != null || itterableCoord.isOverflow) return rate;

    return _findRateToNextObject(from, offset, jumpOffset, rate + 1);
  }

  /// It's provided for finding `info` about [end of board] or [nextChecker]
  // ! Returns
  ///     [null] if the way is clear
  ///     [CheckerPositionInfo] `itterableOffset` if `nextObject` is `end of board`
  ///     [CheckerPositionInfo] if there is checker on thew way(color doesn't metter);
  ///     [CheckerPositionInfo] - `nextObjectRate` `0` if `nextChecker` is not dangure.
  ///                                              `1` if `jumpOffset` does not allow to jump to `nextObject`
  ///                                              `rate` if there are objects to which `checker` can jump
  CheckerPositionInfo _findCheckerOnTheWay(Checker checker, Coord offset) {
    CheckerPositionInfo info = CheckerPositionInfo(offset);
    final jumpOffset = checker.offsetStructure.jumpOffset;

    final nextObjectRate =
        _findRateToNextObject(checker.coord, offset, jumpOffset);

    final itterableCoord = checker.coord + offset * nextObjectRate;
    final itterableChecker = _chequers.findByCoord(itterableCoord);

    if (itterableChecker == null || itterableChecker == checker) return null;

    info.nextChecker = itterableChecker;

    final nextCoord = itterableCoord + offset;

    if (itterableChecker.color == checker.color || nextCoord.isOverflow)
      return info;

    final afterItterableRate =
        _findRateToNextObject(itterableChecker.coord, offset, BoardUtil.rate);
    final maxRate = jumpOffset - nextObjectRate + 1;

    return info..nextObjectRate = min(maxRate, afterItterableRate - 1);
  }

  List<MoveDetails> findPeacefulMoves(Checker checker) {
    List<MoveDetails> listDetails = [];
    checker.offsetStructure.movableOffsets.forEach((offset) {
      final rate = _findRateToNextObject(
          checker.coord, offset, checker.offsetStructure.jumpOffset + 1);

      if (rate - 1 <= 0) return;

      MoveDetails details = MoveDetails(
        vector: CoordVector(checker.coord, offset, rate - 1),
        activeChecker: checker,
      );

      listDetails.add(details);
    });

    return listDetails;
  }

  /// It's provided for finding one `kill circle` of ways for one checker
  // ! Returns
  ///    [AvailableMoves.empty] if there are not any ways for the checker
  ///    [AvailableMoves.from] if there are ways for the checker
  List<MoveDetails> findAngryMoves(Checker checker) {
    List<MoveDetails> listDetails = [];
    checker.offsetStructure.killOffsets.forEach((offset) {
      final positionInfo = _findCheckerOnTheWay(checker, offset);
      if (positionInfo == null || positionInfo.vector.isNull) return;

      MoveDetails details = positionInfo.toMoveDetails(checker);

      listDetails.add(details);
    });

    return listDetails;
  }

  // void moveChecker(MoveDetails details) {
  //   details.activeChecker.jumpTo(details.coord);

  //   if (details.destroyedCheck==er != null) {
  //     _chequers = _chequers.removeChecker(details.destroyedChecker);
  //   }
  // }

  /// Provided for finding `queen coord`
  // ! Returns
  /// [min coord] to endentify queen
  static Coord coordToEndentifyQueen(CheckerColor color) {
    if (color == CheckerColor.black) return Coord(0, 9);

    return Coord(0, 7);
  }

  static bool isQueen(Checker checker) {
    if (checker.type == CheckerType.queen) return true;

    final queenCoord = coordToEndentifyQueen(checker.color);

    return checker.coord > queenCoord;
  }

  /// Manage offsets for checkers by [CheckerColor]
  static Offsets offsetsByColor(CheckerColor color) =>
      color == CheckerColor.white
          ? RuleConstants.offsetsForWhite
          : RuleConstants.offsetsForBlack;
}

class CheckerPositionInfo {
  /// Is the next checker on the way
  // ! Filled
  ///   [null] if there are not any checkers on the way
  ///   [Checker] if there is checker on the way
  Checker nextChecker;

  /// Is rate to the next `object` on the way
  ///  ! Filled
  ///   [0] if there is [nextChecker], but the next object is next to it
  ///   [rate to end of board] if [nextChecker] is null
  ///   [rate to nextChecker] if [nextChecker] not null
  int nextObjectRate = 0;

  /// Info was calculated by this offset
  ///  ! Filled
  /// [Coord] if it was in calculation
  final Coord itterableOffset;

  CheckerPositionInfo(this.itterableOffset);

  MoveDetails toMoveDetails(Checker checker) => MoveDetails(
      vector: vector, destroyedChecker: nextChecker, activeChecker: checker);

  CoordVector get vector {
    return CoordVector(nextChecker.coord, itterableOffset, nextObjectRate);
  }
}
