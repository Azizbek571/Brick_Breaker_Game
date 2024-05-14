import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHeight;
  final brickWidth;
  final bool brickBroken;
  MyBrick(
      {this.brickHeight,
      this.brickWidth,
      this.brickX,
      this.brickY,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            // alignment: Alignment((2*brickX+brickWidth)/(2-brickWidth), brickX),
            alignment: Alignment((3*brickX+brickHeight)/(3-brickWidth), brickX),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.height * brickWidth / 2,
                color: Color.fromARGB(255, 6, 25, 57),
              ),
            ),
          );
  }
}
