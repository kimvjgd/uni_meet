import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("MOMODU"),
            actions: [
              IconButton(onPressed: (){},icon: Icon(Icons.notifications_none_rounded),)
            ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("내 정보",style: Theme.of(context).textTheme.titleLarge),
              Card(
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        Text("모모대 18학번 모모공학과"),
                        Text("김모모님"),
                        Text("대학생 인증 미완료 상태"),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext child_context) {
                                    return AlertDialog(
                                      content: Text(
                                          "에브리타임 캡쳐 스크린을 선택 후, 전송하기를 눌러주세요.\n 24시간 이내로 확인 도와드릴게요!"),
                                      actions: [
                                        Center(
                                          child: Column(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                  },
                                                  child: Text("파일 찾아보기")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                  },
                                                  child: Text("전송하기")),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "인증에 실패하셨나요?",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Text("술게임",style: Theme.of(context).textTheme.titleLarge),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Card(
                      child: Container(
                        height: 100,
                        width: 130,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("인원 수 별 술게임",style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      ),),
                    Card(
                      child: Container(
                        height: 100,
                        width: 130,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("난이도 별 술게임",style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      ),),
                    Card(
                      child: Container(
                        height: 100,
                        width: 130,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("상황 별 술게임",style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      ),),
                  ],),
              ),
              Text("공지사항",style: Theme.of(context).textTheme.titleLarge),
              Container(height: 70,),
              Text("내가 쓴 글",style: Theme.of(context).textTheme.titleLarge),
              Container(height: 70,),
            ],
          ),
        )
    );
    }
}
