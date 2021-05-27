import 'package:flutter/rendering.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/touch_details.dart';
import 'package:flutter_checkers/util/board.dart';

class Coord {
  final int row;
  final int column;

  static Coord get zero => Coord.rated(0);

  Coord(this.row, this.column);
  Coord.rated(int rate)
      : this.row = rate,
        this.column = rate;
  Coord.fromIndex(int index)
      : this.row = index % 10,
        this.column = index ~/ 10;

  int get index => column * 10 + row;
  bool get isWhite => (column + row) % 2 == 0;

  TouchDetails detailsWith(Checker checker) =>
      TouchDetails.filled(checker, this);

  bool get isOverflow =>
      this < Coord(0, 0) || this > Coord.rated(BoardUtil.rate - 1);

  // ? Arithmetic operators
  Coord operator +(Coord other) =>
      Coord(row + other.row, column + other.column);
  Coord operator -(Coord other) =>
      Coord(row - other.row, column - other.column);
  Coord operator *(int rate) => Coord(row * rate, column * rate);
  Coord operator /(int rate) => Coord(row ~/ rate, column ~/ rate);

  // ? Logical operators
  bool operator <(Coord other) => row < other.row || column < other.column;
  bool operator >(Coord other) => row > other.row || column > other.column;
  bool operator <=(Coord other) => row <= other.row || column <= other.column;
  bool operator >=(Coord other) => row >= other.row || column >= other.column;
  @override
  bool operator ==(Object other) =>
      other is Coord && row == other.row && column == other.column;

  @override
  int get hashCode => index.hashCode;
}
