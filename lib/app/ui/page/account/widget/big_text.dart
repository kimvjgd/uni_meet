import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText({Key? key, required this.headText}) : super(key: key);
  final String headText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        headText , style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,),
      ),
    );
  }
}
