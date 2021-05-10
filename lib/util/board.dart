import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/util/screen.dart';

class BoardUtil {
  static int rate;
  static double maxSize = 500.0;

  static void setRate(int _rate) => rate = _rate;

  static double get squareSize => boardSize / rate;

  static double get boardSize {
    if (ScreenUtil.width > maxSize) return maxSize;

    return ScreenUtil.width;
  }
}
