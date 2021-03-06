import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/secret/game_list.dart';
import 'dart:io' show Platform;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _expand_game = new List<bool>.generate(10, (int index) => false);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: app_lightyellow,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: _size.width*0.94,
          height: _size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 10, 10),
                child: Image.asset("assets/images/game_title_ios.png"),),

              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text:TextSpan(children: [
                          TextSpan(text: "난이도 낮음 ", style: TextStyle(color: app_green,fontSize: 17,fontFamily: 'Game')),
                          TextSpan(
                              text: "슬슬 분위기를 풀어볼까 ~?",
                              style: TextStyle(color: Colors.grey[800],fontFamily: 'Game'))
                        ]),
                      ),
                    ),
                    for (int i = 0; i < 3; i++) _gameCard(i),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text:TextSpan(children: [
                          TextSpan(text: "난이도 중간 ", style: TextStyle(color: app_green,fontSize: 17,fontFamily: 'Game')),
                          TextSpan(
                              text: "분위기 좋고 ~!",
                              style: TextStyle(color: Colors.grey[800],fontFamily: 'Game'))
                        ]),
                      ),
                    ),
                    for (int i = 3; i < 8; i++) _gameCard(i),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text:TextSpan(children: [
                          TextSpan(text: "난이도 높음 ", style: TextStyle(color: app_green,fontSize: 17,fontFamily: 'Game')),
                          TextSpan(
                              text: "잘봐 고수들의 대결이다",
                              style: TextStyle(color: Colors.grey[800],fontFamily: 'Game'))
                        ]),
                      ),
                    ),
                    for (int i = 8; i < 10; i++) _gameCard(i),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70,20,70,20),
                      child: Image.asset("assets/images/game_tail.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _gameCard(int index) {
    return Card(
      elevation: 5,
      shadowColor: app_deepyellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      color: Colors.white,
      child: ExpansionTile(
          trailing: Icon(
              _expand_game[index]
                  ? Icons.arrow_drop_down_rounded
                  : Icons.arrow_drop_up_rounded,
              size: 50,
              color: app_deepyellow),
          onExpansionChanged: (bool expanded) {
            setState(() => _expand_game[index] = expanded);
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(gameTitleList[index]['title'].toString(),
                style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Game")),
            Text(gameTitleList[index]['sub'].toString(),
                style: TextStyle(
                    color: app_red.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                 // fontFamily: 'Game'
                )),
          ]),
          children: [_contents(index)]),
    );
  }

  Padding _contents(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: "인원 ", style: TextStyle(color: app_deepyellow)),
              TextSpan(
                  text: gameTitleList[index]['people'].toString(),
                  style: TextStyle(color: Colors.black))
            ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan
                  (children: [
              TextSpan(text: "인트로 ", style: TextStyle(color: app_deepyellow)),
              TextSpan(
                  text: gameTitleList[index]['intro'].toString(),
                  style: TextStyle(color: Colors.black))
            ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    children: _Split(gameTitleList[index]['description'].toString())
                )),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _Split(String str){
    var parts = str.split('_');
    List<TextSpan> textWidgets = [];
    for(var element in parts){
      if(element.contains("Step")) {textWidgets.add(TextSpan(text: element,style: TextStyle(color: app_red)));}
      else textWidgets.add(TextSpan(text: element,style: TextStyle(color: Colors.black)));
    }

    return textWidgets;
  }
}
