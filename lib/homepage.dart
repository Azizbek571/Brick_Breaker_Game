import 'dart:async';
import 'dart:ffi';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/brick.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  enum direction {UP, DOWN} 

class _HomePageState extends State<HomePage> {
  double ballX = -0.2;
  double ballY = 0;
  var ballDirection = direction.DOWN;
  double playerX = -0.2;
  double playerWidth = 0.4;
  double brickX = 0;
  double brickY = 0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.05;
  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerDead()){
        timer.cancel();
        isGameOver = true;
      }
    });
  }

   bool isPlayerDead(){
    if (ballY >= 1){
      return true;
    }
    return false;
   }

     void moveBall(){
     setState(() {
        if (ballDirection == direction.DOWN){
            ballY += 0.01;
      }else if (ballDirection == direction.UP){
       ballY -= 0.01;
      }
     });
     }

     void updateDirection(){
    setState(() {
        if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth){
        ballDirection = direction.UP;
      } else if (ballY <= -0.9){
        ballDirection = direction.DOWN;

      }
    });
     }

    void moveLeft(){
      setState(() {
        if (!(playerX - 0.2 < -1)){
          playerX -= 0.2;
        }
      });
    }
    void moveRight(){
 setState(() {
         if (!(playerX + playerWidth >= 1)){
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
                GameOverScreen(isGameOver: isGameOver),
                MyBall(ballX: ballX, ballY: ballY),
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth),

                MyBrick(
                  brickX: brickX,
                  brickY: brickY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                )
                 

                 


              ],
            ),
          ),
        ),
      ),
    );
  }
}
