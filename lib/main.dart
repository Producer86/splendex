import 'package:flutter/material.dart';

import 'presentation/Board/BoardView.dart';
import 'presentation/dependencies.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 66,
          backgroundColor: Colors.black,
          title: Row(children: [
            // no svg support for web yet...
            Image.asset(
              'assets/cards/splendex.png',
              height: 72,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'splendex',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            )
          ]),
        ),
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
