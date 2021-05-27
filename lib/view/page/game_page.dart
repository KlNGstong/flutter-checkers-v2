import 'package:flutter/material.dart';
import 'package:flutter_checkers/config/enums/checker_color.dart';
import 'package:flutter_checkers/model/board.dart';
import 'package:flutter_checkers/model/checker.dart';
import 'package:flutter_checkers/model/coord.dart';
import 'package:flutter_checkers/model/game_controller.dart';
import 'package:flutter_checkers/util/board.dart';
import 'package:flutter_checkers/view/widget/game_board.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameController _gameController;

  @override
  void initState() {
    BoardUtil.setRate(8);
    // _gameController = GameController.autoFilled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _gameController = GameController.custom(Board.from([
      // Checker.common(Coord(0, 1), CheckerColor.black),
      // // // Checker.common(Coord(2, 3), CheckerColor.black),
      // Checker.queen(Coord(5, 6), CheckerColor.black),
      // Checker.queen(Coord(1, 2), CheckerColor.white),
      // Checker.common(Coord(1, 0), CheckerColor.white),

      // Checker.queen(Coord(0, 0), CheckerColor.white),
      // Checker.queen(Coord(1, 1), CheckerColor.black),
      // Checker.queen(Coord(7, 7), CheckerColor.black),

      // Checker.common(Coord(3, 4), CheckerColor.black),
      // Checker.queen(Coord(2, 3), CheckerColor.white),
      // Checker.queen(Coord(4, 3), CheckerColor.white),
      // Checker.queen(Coord(2, 5), CheckerColor.white),
      // Checker.queen(Coord(4, 5), CheckerColor.white),

      // Checker.queen(Coord(3, 3), CheckerColor.white),
      // Checker.queen(Coord(5, 3), CheckerColor.white),
      // Checker.common(Coord(1, 7), CheckerColor.black),
      // Checker.queen(Coord(7, 1), CheckerColor.black)

      // Checker.queen(Coord(2, 6), CheckerColor.white),
      // Checker.queen(Coord(3, 4), CheckerColor.black),
      // Checker.common(Coord(1, 6), CheckerColor.black),
      // Checker.queen(Coord(5, 0), CheckerColor.white),
      // Checker.queen(Coord(3, 6), CheckerColor.black),
      // Checker.queen(Coord(3, 2), CheckerColor.black),

      // Checker.common(Coord(3, 4), CheckerColor.white),
      Checker.common(Coord(3, 4), CheckerColor.white),
      Checker.queen(Coord(2, 2), CheckerColor.black),
      Checker.queen(Coord(2, 4), CheckerColor.black),
      Checker.queen(Coord(3, 1), CheckerColor.black),
      Checker.queen(Coord(4, 4), CheckerColor.black),
      // Checker.queen(Coord(3, 1), CheckerColor.black),

      // Checker.queen(Coord(5, 6), CheckerColor.black),
    ]));
    // _gameController = GameController.autoFilled();
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation: _gameController,
              builder: (context, widget) {
                return GameBoard(
                  onTapSquare: _gameController.onTapSquare,
                  board: _gameController.board,
                  touchDetails: _gameController.touchDetails,
                  onTapChecker: _gameController.onTapChecker,
                  onTapActiveSquare: _gameController.onTapActiveSquare,
                );
              })),
    );
  }
}
