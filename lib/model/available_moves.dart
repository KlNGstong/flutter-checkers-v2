import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/move_details.dart';

class AvailableMoves {
  final List<MoveDetails> available;

  bool isActiveSquare(Coord coord) {
    final founded = available.firstWhere(
        (details) => details.vector.cross(coord),
        orElse: () => null);

    return founded != null;
  }

  bool isDangerChecker(Coord coord) {
    final founded = available.firstWhere(
        (details) => details?.destroyedChecker?.coord == coord,
        orElse: () => null);

    return founded != null;
  }

  MoveDetails findDetails(Coord coord) => available
      .firstWhere((details) => details.vector.cross(coord), orElse: () => null);

  AvailableMoves.empty() : this.available = [];
  AvailableMoves.from(this.available);

  bool get isEmpty => available.isEmpty;
}
