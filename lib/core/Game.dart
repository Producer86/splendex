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
      return [BoardCard(index, card)];
    }

    switch (turn) {
      case Turn.First:
        turn = Turn.Second;
        peek1 = index;
        return [BoardCard.faceUp(index, card)];
      case Turn.Second:
        tryCount++;
        peek2 = index;
        turn = Turn.Third;
        return [BoardCard.faceUp(index, card)];
      case Turn.Third:
        final res = <BoardCard>[BoardCard.faceUp(index, card)];
        if (!isMatch()) {
          res.add(BoardCard.faceDown(peek1, board[peek1]));
          res.add(BoardCard.faceDown(peek2, board[peek2]));
        } else {
          board[peek1].state = CardState.Removed;
          board[peek2].state = CardState.Removed;
        }
        turn = Turn.Second;
        peek1 = index;
        return res;
      default:
        return [BoardCard(index, card)];
    }
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
