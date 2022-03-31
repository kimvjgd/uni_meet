import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Text("""
안녕하세요!👋
즐거운 만남을 위해
당신에 대해 알려주세요."""),
          ),
        ],
      ),
    );
  }
}
