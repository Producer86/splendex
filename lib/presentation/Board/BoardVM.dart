import 'dart:async';
import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:splendex/core/Card.dart';

class Board {
  final int cardCount;
  final List<BoardCard> Function(int) onClick;
  final List<StreamController<int>> _controllers;
  final List<StreamController<CardState>> _presenters;

  Board({@required this.cardCount, @required this.onClick})
      : _controllers = List<StreamController<int>>.generate(
            cardCount, (index) => StreamController<int>()),
        _presenters = List<StreamController<CardState>>.generate(
            cardCount, (index) => StreamController<CardState>()) {
    // delegate clicked card info
    for (var controller in _controllers) {
      controller.stream.listen((index) {
        // get back list of cards to turn
        final cardsToTurn = onClick(index);
        for (var card in cardsToTurn) {
          if (card.state != CardState.Removed) {
            _presenters[card.index].sink.add(card.state);
          }
        }
      });
    }
  }

  Stream<CardState> presenterAt(int index) {
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
