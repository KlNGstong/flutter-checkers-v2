import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/coord_vector.dart';

class MoveDetails {
  CoordVector vector;
  Checker destroyedChecker;
  Checker activeChecker;

  bool get isPeacefulMove => destroyedChecker == null;
  bool get isAngureMove => destroyedChecker != null;
  bool get isNone => vector == null || vector.isNone;

  DirectlyMove directly(Coord to) => DirectlyMove(
      destroyedChecker: destroyedChecker,
      activeChecker: activeChecker,
      endPoint: to);

  MoveDetails({this.vector, this.destroyedChecker, this.activeChecker});
}

class DirectlyMove extends MoveDetails {
  final Checker destroyedChecker;
  final Checker activeChecker;
  final Coord endPoint;

  DirectlyMove({this.destroyedChecker, this.activeChecker, this.endPoint});
}
