import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  var _expand_game = new List<bool>.generate(20, (int index) => false);
  var _title_game = new List<String>.generate(20, (int index) => "게임 타이틀");

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: app_lightyellow,
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 10, 10),
              child: Image.asset("assets/images/game_title.png"),
            ),
            Container(child: Text("난이도 낮음"),),
            Expanded(
              child: ListView(
                children: [
                  for (int i=0; i<_expand_game.length; i++) _gameCard(i),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _gameCard(int index){
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
                : Icons.arrow_drop_up_rounded
            ,size:50, color: app_deepyellow
        ),
        onExpansionChanged:(bool expanded){
        setState(() => _expand_game[index] = expanded);
        },
        title:  Text(_title_game[index]),
        children:[_contents(index)]
      ),
    );
  }

  Padding _contents(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                  text:
                  TextSpan(
                      children: [
                        TextSpan(text:"인원 ",style: TextStyle(color: app_red)),
                        TextSpan(text:"3~5명 이상",style: TextStyle(color: Colors.black))
                      ]
                  )
              ),
              RichText(
                  text:
                  TextSpan(
                      children: [
                        TextSpan(text:"특징 ",style: TextStyle(color: app_red)),
                        TextSpan(text:"눈치/다굴 조심",style: TextStyle(color: Colors.black))
                      ]
                  )
              ),
            ],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text:"Step1 ",style: TextStyle(color: app_red)),
                        TextSpan(text:"가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사",style: TextStyle(color: Colors.black))
                      ]
                  )
              ),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text:"Step2 ",style: TextStyle(color: app_red)),
                        TextSpan(text:"가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사",style: TextStyle(color: Colors.black))
                      ]
                  )
              ),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text:"Step3 ",style: TextStyle(color: app_red)),
                        TextSpan(text:"가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사가나다마라마바사가나다라마바사",style: TextStyle(color: Colors.black))
                      ]
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}



