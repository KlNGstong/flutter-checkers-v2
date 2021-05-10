import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_checkers/model/coord.dart';

class Offsets extends ListBase {
  final List<Coord> l;

  set length(int newLength) => l.length = newLength;

  int get length => l.length;

  Coord operator [](int index) => l[index];
  void operator []=(int index, dynamic value) => l[index] = value;

  List<Coord> except(Coord coord) => l.where((el) => el != coord);

  Offsets(this.l);
}
