import 'dart:async';
import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:splendex/core/Card.dart';

class Board {
  final int cardCount;
  final List<BoardCard> Function(int) onClick;
  final List<StreamController<int>> _controllers;
  final List<StreamController<GameCard>> _presenters;

  Board({@required this.cardCount, @required this.onClick})
      : _controllers = List<StreamController<int>>.generate(
            cardCount, (index) => StreamController<int>()),
        _presenters = List<StreamController<GameCard>>.generate(
            cardCount, (index) => StreamController<GameCard>()) {
    // delegate clicked card info
    for (var controller in _controllers) {
      controller.stream.listen((index) {
        // get back list of cards to turn
        final cardsToTurn = onClick(index);
        for (var card in cardsToTurn) {
          _presenters[card.index].sink.add(card.card);
        }
      });
    }
  }

  Stream<GameCard> presenterAt(int index) {
    return _presenters[index].stream;
  }

  VoidCallback inputAt(int index) {
    return () => _controllers[index].sink.add(index);
  }

  void dispose() {
    for (var controller in _controllers) {
      controller.close();
    }
  }
}
