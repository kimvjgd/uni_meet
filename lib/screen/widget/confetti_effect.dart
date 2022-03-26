import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class Confetti extends StatefulWidget {
  const Confetti({Key? key}) : super(key: key);

  @override
  _ConfettiState createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  late ConfettiController _controllerRight;
  late ConfettiController _controllerLeft;

  @override
  void initState() {
    _controllerRight = ConfettiController(duration: const Duration(seconds: 5));
    _controllerLeft = ConfettiController(duration: const Duration(seconds: 5));

    _controllerRight.play();
    _controllerLeft.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerRight.dispose();
    _controllerLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topRight,
        child: ConfettiWidget(
          confettiController: _controllerRight,
          blastDirection: (-3/4)*pi,
          particleDrag: 0.05,
          emissionFrequency: 0.02,
          numberOfParticles: 20,
          gravity: 0.15,
          shouldLoop: false,
          minimumSize: Size(7,19),
          maximumSize: Size(8,20),
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ], // manually specify the colors to be used
        ),
      ),

      Align(
        alignment: Alignment.topLeft,
        child: ConfettiWidget(
          confettiController: _controllerLeft,
          blastDirection:(-1/4)*pi,
          particleDrag: 0.05,
          emissionFrequency: 0.02,
          numberOfParticles: 20,
          gravity: 0.15,
          shouldLoop: false,
          minimumSize: Size(7,19),
          maximumSize: Size(8,20),
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ], // manually specify the colors to be used
        ),
      ),
    ],);
  }
}

