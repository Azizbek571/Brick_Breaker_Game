import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHeight;
  final brickWidth;
   MyBrick({this.brickHeight, this.brickWidth,this.brickX, this.brickY });

  @override
  Widget build(BuildContext context) {
    return   Container(alignment: Alignment(brickX,brickY),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * brickHeight / 2,
                      width: MediaQuery.of(context).size.height * brickWidth / 2,
                      color:Color.fromARGB(255, 6, 25, 57),
                    ),
                  ) ,
                  );
  }
}