import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color:Colors.blue, letterSpacing: 0, fontSize: 25));
    
  
 


  GameOverScreen({required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(children: [
          Container(
            alignment: Alignment(0, -0.3),
            child: Text(
              ' G A M E  O V E R',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 245, 247, 248)),
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            child: GestureDetector(
              onTap: function ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Color.fromARGB(255, 7, 51, 83),
                  child: Text(
                    'Play again',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 221, 232, 237)),
                  ),
                ),
              ),
            ),
          )
        ],)
        : Container();
  }
}
