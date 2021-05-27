import 'package:flutter_checkers/model/available_moves.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/move_details.dart';

class TouchDetails {
  Checker activeChecker;
  Coord touchedSquareCoord;
  AvailableMoves availableMoves;

  bool get includeChecker => activeChecker != null;
  bool get includeMoves => availableMoves != null;

  TouchDetails.filled(this.activeChecker, this.touchedSquareCoord);
  TouchDetails.empty();
}

class DirectlyMoveDetails {
  Checker activeChecker;
  MoveDetails details;
  Coord to;
}
