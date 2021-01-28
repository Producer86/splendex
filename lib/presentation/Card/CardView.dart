import 'package:flutter/material.dart';
import 'package:splendex/core/Card.dart';

class CardView extends StatelessWidget {
  final VoidCallback onTap;
  final Stream<CardState> content;

  const CardView({Key key, @required this.onTap, @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: StreamBuilder<CardState>(
            stream: content,
            builder: (context, snapshot) {
              final state = snapshot.data;
              switch (state) {
                case CardState.FaceUp:
                  return Text('FaceUp');
                case CardState.FaceDown:
                  return Text('FaceDown');
                case CardState.Removed:
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
