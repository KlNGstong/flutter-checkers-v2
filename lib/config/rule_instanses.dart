import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/offsets.dart';

class RuleConstants {
  static final Offsets offsetsAround =
      Offsets([...offsetsForWhite, ...offsetsForBlack]);

  static final Offsets offsetsForWhite = Offsets([Coord(1, -1), Coord(-1, -1)]);

  static final Offsets offsetsForBlack = Offsets([Coord(1, 1), Coord(-1, 1)]);
}
