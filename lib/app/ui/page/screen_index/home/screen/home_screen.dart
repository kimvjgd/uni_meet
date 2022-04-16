import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/notice_repository.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/game_screen.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_list_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/notice_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/notice_list_screen.dart';

import '../../../../../controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.white,
          elevation: 2,
          title: Text("홈",style: TextStyle(color:Colors.grey[800]),),
            actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded,color: Colors.grey[800],),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/momo' +
                            AuthController.to.user.value.localImage.toString() +
                            '.png'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AuthController.to.user.value.university.toString() +
                              " " +
                              AuthController.to.user.value.grade.toString() +
                              "학번 | " +
                              AuthController.to.user.value.major.toString(),
                          style: TextStyle(color: app_systemGrey1),
                        ),
                        // AuthController.to.user.value.auth!
                        //     ? Text("학생 인증 완료")
                        //     : Row(
                        //         children: [
                        //           Text(
                        //             "학생 인증 미완료  ",
                        //             style: TextStyle(color: app_systemGrey1),
                        //           ),
                        //           TextButton(
                        //               style: TextButton.styleFrom(
                        //                   padding: EdgeInsets.zero,
                        //                   minimumSize: Size.zero,
                        //                   tapTargetSize:
                        //                       MaterialTapTargetSize.shrinkWrap,
                        //                   alignment: Alignment.centerLeft),
                        //               onPressed: () {
                        //                 showDialog(
                        //                     context: context,
                        //                     barrierDismissible: false,
                        //                     builder:
                        //                         (BuildContext child_context) {
                        //                       return AlertDialog(
                        //                         content: Text(
                        //                             "에브리타임 캡쳐 스크린을 선택 후, 전송하기를 눌러주세요.\n 24시간 이내로 확인 도와드릴게요!"),
                        //                         actions: [
                        //                           Center(
                        //                             child: Column(
                        //                               children: [
                        //                                 ElevatedButton(
                        //                                     onPressed: () {},
                        //                                     child: Text(
                        //                                         "파일 찾아보기")),
                        //                                 ElevatedButton(
                        //                                     onPressed: () {},
                        //                                     child:
                        //                                         Text("전송하기")),
                        //                               ],
                        //                             ),
                        //                           )
                        //                         ],
                        //                       );
                        //                     });
                        //               },
                        //               child: Text(
                        //                 "인증에 실패하셨나요?",
                        //                 style: TextStyle(
                        //                   color: app_red.withOpacity(0.8),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        Text(
                          AuthController.to.user.value.nickname.toString() +
                              "님",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: _size.height * 0.2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                    child: Image.asset("assets/images/game_banner.png"),
                    onTap: () {
                      Get.to(GameScreen());
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("내가 쓴 글", style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                      onPressed: () {
                        Get.to(MyPostListScreen());
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              FutureBuilder<List<PostModel>>(
                  initialData: [
                    PostModel(
                        postKey: '',
                        host: '',
                        place: '',
                        numComments: 0,
                        headCount: 0,
                        title: '',
                        createdDate: DateTime.now(),
                        content: '',
                        hostpushToken: '',
                        hostUni: '',
                        hostNick: '',
                        hostGrade: '')
                  ],
                  future: PostRepository().getTwoPosts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    Logger().d(snapshot.data!.length);
                    return SizedBox(
                      height: 200, // 하드코딩 수정 예정
                      child: ListView.builder(
                        physics:NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(MyPostDetailScreen(
                                  data: snapshot.data![index],
                                ));
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("공지사항", style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                      onPressed: () {
                        Get.to(NoticeListScreen());
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              FutureBuilder<List<NoticeModel>>(
                  initialData: [
                    NoticeModel(
                        title: '', description: '', createdDate: DateTime.now())
                  ],
                  future: NoticeRepository().getThreeNotices(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    Logger().d(snapshot.data!.length);
                    return SizedBox(
                      height: 200, // 하드코딩 수정 예정
                      child: ListView.builder(
                        physics:NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(NoticeDetailScreen(
                                  data: snapshot.data![index],
                                ));
                                // snapshot.data![index];
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }),

            ],
          ),
        ));
  }
}
