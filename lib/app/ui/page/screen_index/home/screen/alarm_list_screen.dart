import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/repository/news_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/error_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chatroom_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/game_screen.dart';
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
            color: Colors.grey[800],
          ),
          title: Text(
            "알림",
            style: TextStyle(color: Colors.grey[800]),
          ),
          actions: [
            //알림 온오프 기능 나중에 ...
            // IconButton(
            //   onPressed: () {
            //     Get.to(AlarmSettingScreen());
            //   },
            //   icon: Icon(
            //     Icons.settings,
            //     color: Colors.grey[800],
            //   ),
            // )
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              NewsRepository.deleteALLNEWS();
            },
            child: Text("모두지우기")),
          Expanded(
            child: FutureBuilder<List<NewsModel>>(
                future: NewsRepository().getAllNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const CircularProgressIndicator();
                  if (!snapshot.hasData) {
                    return Center(child: Text("새 소식이 없습니다 !"));
                  } else if (snapshot.hasError) {
                    return Container(child: Text("오류 발생"));
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context,index){return Divider(color: divider,);},
                      itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                _onTap(snapshot.data![index].type,
                                    snapshot.data![index].address);
                              },
                              child: ListTile(
                           //     leading: Icon(Icons.bubble_chart_outlined),
                                title: Text(snapshot.data![index].news.toString()),
                            //    trailing: Text("날짜"),
                              ),
                            ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  _onTap(int? type, String? address) {
    //해당 게시글로 이동
    if (type == 1) {
      Future<PostModel> Apost = PostRepository().getAPost(address.toString());
      PostModel post;
      Apost.then((data) {
        post = data;
        Get.to(PostDetailScreen(post: post));
      }, onError: (e) {

        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("MOMODU",textAlign: TextAlign.center,),
            content: Text('삭제된 게시글입니다 !',textAlign: TextAlign.center,),
            contentPadding: EdgeInsets.only(top: 5),
            actions: [
              Center(
                child: TextButton(onPressed: (){Get.back();},
                    child: Text('돌아가기',style: TextStyle(color:app_systemGrey1
                ),)),
              ),
            ],
          );
        });

      });
    }
    //해당 채팅방으로 이동
    else if (type == 2) {
      Get.to(
          () => ChatroomScreen(
                chatroomKey: address.toString(),
              ),
          binding: InitBinding.chatroomBinding(address.toString()));
    }
    //공지사항 으로 이동
    else if (type == 3) {
      print("3번");
    } else {
      print("안됨");
      return;
    } //클릭 안됨
  }
}
