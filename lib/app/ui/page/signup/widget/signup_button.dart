import 'package:flutter/material.dart';

class signup_button extends StatelessWidget {

    final VoidCallback onPressed;
  const signup_button({
    required this.onPressed,
    Key? key,
    required Size size,
  }) : _size = size, super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size.width*0.85,
      height: _size.height*0.06,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  )
              )
          ),
          onPressed: onPressed,
          child: Text('확        인')),
    );
  }
}