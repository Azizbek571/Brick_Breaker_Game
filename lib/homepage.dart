import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ballX = 0;
  double ballY = 0;
  double playerX = 0;
  double playerWidth = 0.3;
  bool hasGameStarted = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY += 0.006;
      });
    });
  }

    void moveLeft(){
      setState(() {
        if (!(playerX - 0.2 <= -1)){
          playerX -= 0.2;
        }
      });
    }
    void moveRight(){
 setState(() {
         if (!(playerX + 0.2 >= 1)){
          playerX += 0.2;
        }
      });
    }



  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
       moveLeft();
        }else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Center(
            child: Stack(
              children: [
                CoverScreen(hasGameStarted: hasGameStarted),
                MyBall(ballX: ballX, ballY: ballY),
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth),
                 

                 Container(
                  alignment: Alignment(playerX, 0.9),
                  child: Container(
                  color: Colors.red,
                  width: 4,
                  height: 15,
                  ),
                  )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
