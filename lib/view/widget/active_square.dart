import 'package:flutter/material.dart';
import 'package:flutter_checkers/util/board.dart';

class ActiveSquare extends StatelessWidget {
  const ActiveSquare({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(BoardUtil.squareSize * .4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
