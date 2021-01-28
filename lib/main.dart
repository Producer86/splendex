import 'package:flutter/material.dart';

import 'presentation/Board/BoardView.dart';
import 'presentation/dependencies.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Center(
          child: GameContainer(
            child: Builder(
              builder: (context) =>
                  BoardView(board: BoardProvider.of(context).board),
            ),
          ),
        ),
      )),
    );
  }
}

void main() {
  runApp(MyApp());
}
