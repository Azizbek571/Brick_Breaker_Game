import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;

  MyBall({required this.ballX, required this.ballY});

  @override
  Widget build(BuildContext context) {
    return 
              Container(
                alignment: Alignment(ballX, ballY),
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 22, 213),
                      shape: BoxShape.circle),
                ),
              );
  }
}