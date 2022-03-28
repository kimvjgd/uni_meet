import 'package:flutter/material.dart';

class MbtiSelector extends StatelessWidget {
  const MbtiSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        child: MaterialButton(
            child: Text("MBTI"),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                        child: Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text("분석형"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _mbti("INTJ", context),
                                  _mbti("INTP", context),
                                  _mbti("ENTJ", context),
                                  _mbti("ENTP", context),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text("외교형"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _mbti("INFJ", context),
                                  _mbti("INFP", context),
                                  _mbti("ENFJ", context),
                                  _mbti("ENFP", context),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text("관리자형"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _mbti("ISTJ", context),
                                  _mbti("ISFJ", context),
                                  _mbti("ESTJ", context),
                                  _mbti("ESFJ", context),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text("탐험가형"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _mbti("ISTP", context),
                                  _mbti("ISFP", context),
                                  _mbti("ESTP", context),
                                  _mbti("ESFP", context),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
  
  TextButton _mbti(String text,context){
    return TextButton(
      child: Text(text),
      style: ButtonStyle(
        textStyle:MaterialStateProperty.all(TextStyle(fontSize: 17)),
        foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
              if (states
                  .contains(MaterialState.pressed)) {
                return Colors.black;
              } else {
                return Colors.grey;
              }
            }),
          padding:
          MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(16)),

          backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                if (states
                    .contains(MaterialState.pressed)) {
                  return Colors.white;
                } else {
                  return Colors.grey[200];
                }
              }),
          shape: MaterialStateProperty.resolveWith(
                  (states) {
                if (states
                    .contains(MaterialState.pressed)) {
                  return RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30));
                } else {
                  return null;
                }
              })),

      onPressed: (){
        Navigator.pop(context);
      },
    );
    
  }
}
