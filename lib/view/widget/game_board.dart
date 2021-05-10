import 'package:flutter/material.dart';
import 'package:flutter_checkers/model/chequers.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/touch_details.dart';
import 'package:flutter_checkers/util/board.dart';
import 'package:flutter_checkers/view/widget/active_square.dart';
import 'package:flutter_checkers/view/widget/checker_view.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key key, this.onTapSquare, this.chequers, this.touchDetails})
      : super(key: key);

  final TouchDetails touchDetails;
  final Chequers chequers;
  final Function(Coord) onTapSquare;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: BoardUtil.boardSize * 1.1,
      height: BoardUtil.boardSize * 1.1,
      child: Center(
        child: SizedBox(
          width: BoardUtil.boardSize,
          height: BoardUtil.boardSize,
          child: Table(
            children: List.generate(
              BoardUtil.rate,
              (column) => TableRow(
                children: List.generate(
                  BoardUtil.rate,
                  (row) => _square(Coord(row, column)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _square(Coord coord) {
    final founded = chequers.findByCoord(coord);
    final isActiveChecker = touchDetails.includeChecker
        ? touchDetails.activeChecker.coord == coord
        : false;

    final isDangerChecker = touchDetails.includeMoves
        ? touchDetails.availableMoves.isDangerChecker(coord)
        : false;

    final isActiveSquare = touchDetails.includeMoves
        ? touchDetails.availableMoves.isActiveSquare(coord)
        : false;

    Widget template = Container();
    Color squareColor = coord.isWhite ? Colors.white : Colors.grey;

    if (founded != null) template = CheckerView(founded);

    if (isActiveChecker) squareColor = Colors.blue[100];

    if (isDangerChecker) squareColor = Colors.red[400];

    if (isActiveSquare) template = ActiveSquare();

    return GestureDetector(
        onTap: () => onTapSquare(coord),
        child: Container(
            color: squareColor,
            width: BoardUtil.squareSize,
            height: BoardUtil.squareSize,
            child: Stack(
              children: [
                template,
                // Text(coord.index.toString()),
              ],
            )));
  }
}
