import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/repository/news_repository.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chatroom_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/alarm_screen.dart';
import 'package:get/get.dart';

import '../../../../../binding/init_bindings.dart';
import '../../../../../data/model/firestore_keys.dart';
import '../../../../../data/model/news_model.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../../data/repository/post_repository.dart';
import 'mypost_detail_screen.dart';

class AlarmList extends StatefulWidget {
  const AlarmList({Key? key}) : super(key: key);

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 2,
            leading: BackButton(
              color: Colors.black,
            ),
            title: Text(
              "알림",
              style: TextStyle(color: Colors.grey[800]),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(AlarmSettingScreen());
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[800],
                ),
              )
            ]),
        body:FutureBuilder<List<NewsModel>>(
            future: NewsRepository().getAllNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const CircularProgressIndicator();
              if (!snapshot.hasData) {
                return Center(child: Text("새 소식이 없습니다 !"));
              } else if (snapshot.hasError) {
                return Container(child: Text("오류 발생"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Column(
                          children: [
                            InkWell(
                                child: ListTile(
                                  leading: Icon(Icons.bubble_chart_outlined),
                                  title:
                                  Text(snapshot.data![index].news.toString()),
                                  subtitle: Text("이동하기"),
                                  trailing: Text("날짜"),
                                ),
                                onTap:() {
                                  _onTap(snapshot.data![index].type, snapshot
                                      .data![index].address);
                                }
                            ),
                          ],
                        )
                );
              }
            }),
        bottomSheet:Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(onPressed: (){
              NewsRepository.deleteALLNEWS();
            }, child: Text("모두지우기")))
    );

  }

  _onTap(int? type,String? address){
    //해당 게시글로 이동
    if(type==1) {
      Future<PostModel> Apost = PostRepository().getAPost(address.toString());
      PostModel post;
      Apost.then((data) {
        post = data;
        Get.to(PostDetailScreen(post: post));
      }, onError: (e) {
        print(e);
      });

    }
    //해당 채팅방으로 이동
    else if(type==2) {
      Get.to(() => ChatroomScreen(chatroomKey: address.toString(),),
          binding: InitBinding.chatroomBinding(address.toString())
      );
    }
    //공지사항 으로 이동
    else if(type==3) {

    }
    else return;    //클릭 안됨
  }
}
