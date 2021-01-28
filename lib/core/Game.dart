import 'package:meta/meta.dart';
import 'package:splendex/core/Card.dart';

enum Turn { First, Second, Third }

class Game {
  final int cardCount;
  final List<GameCard> board;
  int tryCount = 0;
  int pairCount = 0;
  Turn turn = Turn.First;
  int peek1;
  int peek2;
  bool gameOver = false;

  Game({@required this.cardCount})
      : assert(cardCount % 2 == 0),
        board = List<GameCard>.generate(cardCount,
            (index) => GameCard(value: index, state: CardState.FaceDown));

  List<BoardCard> checkCard(int index) {
    final card = board[index];

    if (gameOver || card.isRemoved || card.isFaceUp) {
      return [BoardCard(index, card.state)];
    }

    switch (turn) {
      case Turn.First:
        turn = Turn.Second;
        peek1 = index;
        return _turnCards([BoardCard.faceUp(index)]);
      case Turn.Second:
        tryCount++;
        peek2 = index;
        turn = Turn.Third;
        return _turnCards([BoardCard.faceUp(index)]);
      case Turn.Third:
        turn = Turn.Second;
        peek1 = index;
        final res = <BoardCard>[BoardCard.faceUp(index)];
        if (!isMatch()) {
          res.add(BoardCard.faceDown(peek1));
          res.add(BoardCard.faceDown(peek2));
        }
        return _turnCards(res);
        break;
      default:
        return [BoardCard(index, card.state)];
    }
  }

  List<BoardCard> _turnCards(List<BoardCard> cards) {
    for (var card in cards) {
      board[card.index].state = card.state;
    }
    return cards;
  }

  bool isMatch() {
    final card1 = board[peek1];
    final card2 = board[peek2];
    final match = card1.value == card2.value;
    if (match && pairCount == cardCount / 2) {
      gameOver = true;
    }
    return match;
  }

  void dispose() {}
}
