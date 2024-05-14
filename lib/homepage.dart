import 'dart:async';

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

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double ballX = -0.2;
  double ballY = 0;
  double ballXincrements = 0.02;
  double ballYincrements = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  double playerX = -0.2;
  double playerWidth = 0.4;
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = 0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  List MyBricks = [
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];

  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < MyBricks.length; i++) {
      if (ballX >= MyBricks[i][0] &&
          ballX <= MyBricks[i][0] + brickWidth &&
          ballY <= MyBricks[i][1] + brickHeight &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;

     double leftSideDist = (MyBricks[i][0] - ballX).abs();
     double rightSideDist = (MyBricks[i][0] - brickWidth - ballX).abs();
     double topSideDist = (MyBricks[i][1] - ballY).abs();
     double bottomSideDist = (MyBricks[i][1] - brickHeight - ballY).abs();
    
    String min = findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
     switch (min){
      case 'left':
      ballXDirection = direction.LEFT;

      break;
      case 'right':
      ballXDirection = direction.RIGHT;
      break;
      case 'up':
      ballYDirection = direction.UP;
      break;
      case 'down':
      ballYDirection = direction.DOWN;
      break;
    
     }

        
        });
      }
    }
  }

  String findMin(double a, double b, double c, double d){
    List<double> myList =  [
      a, b, c, d,
    ];
     double currentMin = a;
     for (int i = 0; i < myList.length; i++){
      if (myList[i] < currentMin){
        currentMin = myList[i];
      }
     }

     if ((currentMin - a).abs() < 0.01){
      return 'left';

     } else if ((currentMin - b).abs() < 0.01){
      return 'right';
     } else if((currentMin - c).abs() < 0.01){
      return 'top';

     } else if ((currentMin - d).abs() < 0.01){
      return 'bottom';
     }
     return '';

  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrements;
      }
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrements;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }


  void resetGame(){
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY =0;
      isGameOver = false;
      hasGameStarted = false;
      MyBricks = [
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
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
                GameOverScreen(isGameOver: isGameOver, function: resetGame,),
                MyBall(ballX: ballX, ballY: ballY),
                MyPlayer(playerX: playerX, playerWidth: playerWidth),
                MyBrick(
                  brickX: MyBricks[0][0],
                  brickY: MyBricks[0][1],
                  brickBroken: MyBricks[0][2],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                ),
                MyBrick(
                  brickX: MyBricks[1][0],
                  brickY: MyBricks[1][1],
                  brickBroken: MyBricks[1][2],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                ),
                MyBrick(
                  brickX: MyBricks[2][0],
                  brickY: MyBricks[2][1],
                  brickBroken: MyBricks[2][2],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
