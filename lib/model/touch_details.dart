import 'package:flutter_checkers/model/available_moves.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';

class TouchDetails {
  Checker activeChecker;
  Coord touchedSquareCoord;
  AvailableMoves _currentCheckerAvailableMoves;
  AvailableMoves get availableMoves => _currentCheckerAvailableMoves;

  bool get includeChecker => activeChecker != null;
  bool get includeMoves => _currentCheckerAvailableMoves != null;

  TouchDetails.filled(this.activeChecker, this.touchedSquareCoord);
  TouchDetails.empty();

  set checker(Checker checker) => activeChecker = checker;
  set touched(Coord coord) => touchedSquareCoord = coord;
  set moves(AvailableMoves availablePieces) =>
      _currentCheckerAvailableMoves = availablePieces;
}
