import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'dart:io' show Platform;
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
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.disabled)) return Color(0x3DC5C5C5);
              else return Colors.green;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.disabled)) return app_systemGrey2;
              else return Colors.green;
             }),
           //  shadowColor:  MaterialStateProperty.resolveWith((states) {
           //    if(states.contains(MaterialState.disabled)) return Colors.transparent;
           //    else return app_red;
           //  }),
           // elevation: MaterialStateProperty.resolveWith((states) {
           //   if(states.contains(MaterialState.disabled)) return 0;
           //   else return 5;
           //    }),
           //  side: MaterialStateProperty.resolveWith((states) {
           //    if(states.contains(MaterialState.disabled)) return BorderSide(width: 2,color:Color(0xFFA3A3A3));
           //    else return BorderSide(width: 2,color: app_red);
           //  }),
          ),
          onPressed:onPressed,
          child: Text(btnText,style: TextStyle(fontSize: 17,color: Colors.white),)),
    );
  }

}