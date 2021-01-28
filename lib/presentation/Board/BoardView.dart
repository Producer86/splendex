import 'package:flutter/material.dart';
import 'package:splendex/presentation/Board/BoardVM.dart';
import 'package:splendex/presentation/Card/CardView.dart';

class BoardView extends StatelessWidget {
  final Board board;
  final int maxCol;
  final int _rowNum;
  final int _rest;

  BoardView({Key key, @required this.board, this.maxCol = 5})
      : _rowNum = (board.cardCount / maxCol).ceil(),
        _rest = board.cardCount % maxCol,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 800,
      child: Table(
        children: <TableRow>[
          for (var i = 0; i < _rowNum; i++)
            TableRow(
              children: <Widget>[
                for (var j = 0; j < maxCol; j++)
                  CardView(
                      onTap: board.inputAt(i * maxCol + j),
                      content: board.presenterAt(i * maxCol + j)),
              ],
            ),
          if (_rest > 0)
            TableRow(
              children: <Widget>[
                for (var j = 0; j > _rest; j++)
                  CardView(
                    onTap: board.inputAt(maxCol + _rowNum + j),
                    content: board.presenterAt(maxCol + _rowNum + j),
                  ),
              ],
            )
        ],
      ),
    );
  }
}
