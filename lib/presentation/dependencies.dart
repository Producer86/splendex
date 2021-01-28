import 'package:flutter/material.dart';
import 'package:splendex/core/Game.dart';

import 'Board/BoardVM.dart';

class GameProvider extends InheritedWidget {
  final Game game;

  GameProvider({Key key, @required this.game, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static GameProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameProvider>();
  }

  @override
  bool updateShouldNotify(GameProvider oldWidget) => oldWidget.game != game;
}

class BoardProvider extends InheritedWidget {
  final Board board;

  BoardProvider({Key key, @required this.board, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static BoardProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BoardProvider>();
  }

  @override
  bool updateShouldNotify(BoardProvider oldWidget) => oldWidget.board != board;
}

class GameContainer extends StatefulWidget {
  final Widget child;

  const GameContainer({Key key, @required this.child}) : super(key: key);

  @override
  _GameContainerState createState() => _GameContainerState();
}

class _GameContainerState extends State<GameContainer> {
  Game game;
  Board board;

  @override
  void initState() {
    super.initState();
    game = Game(cardCount: 10);
    board = Board(cardCount: 10, onClick: game.checkCard);
  }

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      game: game,
      child: BoardProvider(
        board: board,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    board.dispose();
    game.dispose();
    super.dispose();
  }
}
