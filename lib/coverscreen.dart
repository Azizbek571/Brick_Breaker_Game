import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
final bool hasGameStarted;
CoverScreen({required this.hasGameStarted});

  // const CoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted ? Container() : 
     Container(
        alignment: Alignment(0, -0.2),
             child: Text('Tap to play',
                style: TextStyle(fontSize:18, 
                fontWeight: FontWeight.w700, color: Color.fromARGB(255, 5, 8, 196)
                 ),
             ),
    );
  }
}