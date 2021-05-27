import 'package:flutter/material.dart';
import 'package:flutter_checkers/model/board.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/touch_details.dart';
import 'package:flutter_checkers/util/board.dart';
import 'package:flutter_checkers/view/widget/active_square.dart';
import 'package:flutter_checkers/view/widget/checker_view.dart';

class GameBoard extends StatelessWidget {
  const GameBoard(
      {Key key,
      this.onTapSquare,
      this.board,
      this.touchDetails,
      this.onTapChecker,
      this.onTapActiveSquare})
      : super(key: key);

  final TouchDetails touchDetails;
  final Board board;
  final Function(Coord) onTapSquare;
  final Function(Checker) onTapChecker;
  final Function(Coord) onTapActiveSquare;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: BoardUtil.boardSize * 1.1,
      height: BoardUtil.boardSize * 1.1,
      child: Center(
        child: SizedBox(
          width: BoardUtil.boardSize * 1,
          height: BoardUtil.boardSize * 1,
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
    final founded = board.findByCoord(coord);
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
    Function onTap;
    Color squareColor = coord.isWhite ? Colors.white : Colors.grey;

    if (founded != null) {
      template = CheckerView(founded);
      onTap = () => this.onTapChecker(founded);
    }

    if (isActiveChecker) squareColor = Colors.blue[100];

    if (isDangerChecker) squareColor = Colors.red[400];

    if (isActiveSquare) {
      template = ActiveSquare();
      onTap = () => this.onTapActiveSquare(coord);
    }

    return GestureDetector(
        onTap: onTap,
        child: Container(
            color: squareColor,
            width: BoardUtil.squareSize,
            height: BoardUtil.squareSize,
            child: Stack(
              children: [
                template,
                Text(coord.index.toString().split('').reversed.join('')),
              ],
            )));
  }
}
