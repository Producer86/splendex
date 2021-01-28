import 'package:meta/meta.dart';

enum CardState { FaceUp, FaceDown, Removed }

class GameCard {
  CardState state;
  final int value;

  GameCard({
    @required this.value,
    @required this.state,
  });

  bool get isRemoved => state == CardState.Removed;
  bool get isFaceUp => state == CardState.FaceUp;
  bool get isFaceDown => state == CardState.FaceDown;
}

class BoardCard {
  final CardState state;
  final int index;

  const BoardCard(this.index, this.state);

  factory BoardCard.faceUp(int index) => BoardCard(index, CardState.FaceUp);
  factory BoardCard.faceDown(int index) => BoardCard(index, CardState.FaceDown);
}
