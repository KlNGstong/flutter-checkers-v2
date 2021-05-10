import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/config/enums/checker_type.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/util/board.dart';

class CheckerView extends StatelessWidget {
  const CheckerView(this.checker,
      {Key key, this.borderColor = Colors.transparent})
      : super(key: key);

  final Checker checker;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(BoardUtil.squareSize * .2),
      child: Container(
          decoration: BoxDecoration(
            color: checker.color == CheckerColor.black
                ? Colors.black
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(blurRadius: 1.5),
            ],
          ),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(BoardUtil.squareSize * .18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: checker.type == CheckerType.queen
                          ? Colors.yellow
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  )))),
    );
  }
}
