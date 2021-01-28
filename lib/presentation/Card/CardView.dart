import 'package:flutter/material.dart';
import 'package:splendex/core/Card.dart';

const images = [
  AssetImage('assets/cards/angular.png'),
  AssetImage('assets/cards/d3.png'),
  AssetImage('assets/cards/jenkins.png'),
  AssetImage('assets/cards/postcss.png'),
  AssetImage('assets/cards/react.png'),
  AssetImage('assets/cards/redux.png'),
  AssetImage('assets/cards/sass.png'),
  AssetImage('assets/cards/splendex.png'),
  AssetImage('assets/cards/ts.png'),
  AssetImage('assets/cards/webpack.png'),
];

class CardView extends StatelessWidget {
  final VoidCallback onTap;
  final Stream<GameCard> content;
  final Image Function(int) imageLoader;

  const CardView(
      {Key key, @required this.onTap, @required this.content, this.imageLoader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: StreamBuilder<GameCard>(
        stream: content,
        builder: (context, snapshot) {
          final card = snapshot.data;
          switch (card?.state) {
            case CardState.FaceUp:
              return CardBase(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image(image: images[card.value]),
                  ));
            case CardState.FaceDown:
              return CardBase(onTap: onTap, child: Container());
            case CardState.Removed:
              return Container();
            default:
              return CardBase(onTap: onTap, child: Container());
          }
        },
      ),
    );
  }
}

class CardBase extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const CardBase({Key key, @required this.child, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
