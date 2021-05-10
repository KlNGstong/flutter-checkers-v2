import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/coord_vector.dart';

class MoveDetails {
  final CoordVector vector;
  final Checker destroyedChecker;
  final Checker activeChecker;

  MoveDetails({this.vector, this.destroyedChecker, this.activeChecker});
}

class MovePiece {
  final List<MoveDetails> list;
  final Checker activeChecker;

  MoveDetails get firstOne => list.first;

  MovePiece(this.activeChecker, this.list);
}
