import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'dart:io' show Platform;
class DisabledBigButton extends StatelessWidget {

  const DisabledBigButton({
    Key? key,
    required this.btnText,
  }) : super(key: key);

  final String btnText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.85,
      height: Platform.isAndroid
          ? MediaQuery.of(context).size.height*0.067
          : MediaQuery.of(context).size.height*0.04,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(app_systemGrey4),
            foregroundColor: MaterialStateProperty.all(app_systemGrey4)
          ),
          onPressed:(){},
          child: Text(btnText,style: TextStyle(fontSize: 17,color: Colors.white),)),
    );
  }

}