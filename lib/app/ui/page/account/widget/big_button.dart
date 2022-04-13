import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {

  final VoidCallback onPressed;
  const BigButton({
    required this.onPressed,
    Key? key,
    required this.btnText,
  }) : super(key: key);


  final String btnText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.85,
      height: MediaQuery.of(context).size.height*0.06,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  )
              )
          ),
          onPressed: onPressed,
          child: Text(btnText)),
    );
  }
}