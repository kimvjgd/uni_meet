import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uni_meet/app/controller/news_controller.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/notice_repository.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/alarm_list_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/game_screen.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_list_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/notice_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/notice_list_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../controller/auth_controller.dart';
import '../../post/screen/post_detail_screen.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            elevation: 0,
            title: Image.asset('assets/images/logo.png',width: _size.width*0.25,),
            actions: [
              IconButton(
                onPressed: () {Get.to(AlarmList());},
                icon: Icon(Icons.notifications_none_rounded,color: Colors.grey[800])
                  //  : Icon(Icons.notifications_none_rounded,color: app_red)
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/momo' +
                          AuthController.to.user.value.localImage.toString() +
                          '.png'
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AuthController.to.user.value.university.toString() +
                            " " +
                            AuthController.to.user.value.grade.toString() +
                            "?????? | " +
                            AuthController.to.user.value.major.toString(),
                        style: TextStyle(color: app_systemGrey1),
                      ),
                      // AuthController.to.user.value.auth!
                      //     ? Text("?????? ?????? ??????")
                      //     : Row(
                      //         children: [
                      //           Text(
                      //             "?????? ?????? ?????????  ",
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
                      //                             "??????????????? ?????? ???????????? ?????? ???, ??????????????? ???????????????.\n 24?????? ????????? ?????? ??????????????????!"),
                      //                         actions: [
                      //                           Center(
                      //                             child: Column(
                      //                               children: [
                      //                                 ElevatedButton(
                      //                                     onPressed: () {},
                      //                                     child: Text(
                      //                                         "?????? ????????????")),
                      //                                 ElevatedButton(
                      //                                     onPressed: () {},
                      //                                     child:
                      //                                         Text("????????????")),
                      //                               ],
                      //                             ),
                      //                           )
                      //                         ],
                      //                       );
                      //                     });
                      //               },
                      //               child: Text(
                      //                 "????????? ???????????????????",
                      //                 style: TextStyle(
                      //                   color: app_red.withOpacity(0.8),
                      //                 ),
                      //               )),
                      //         ],
                      //       ),
                      Text(
                        AuthController.to.user.value.nickname.toString() +
                            "???",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              if(Platform.isAndroid) CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  reverse: false,
                  viewportFraction:0.85,
                  //aspectRatio: 4.0,
                ),
                itemBuilder: (context, i, id){
                  //for onTap to redirect to another screen
                  if(i==0)
                    return GestureDetector(
                      child: Image.asset("assets/images/beta_banner_2.png"),
                      onTap: () async {
                        final url = "https://sites.google.com/view/momodu-beta/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      },
                    );
                  else if(i==1)
                    return GestureDetector(
                      child: Image.asset("assets/images/manual_banner.png"),
                      onTap: () async {
                        final url = "https://sites.google.com/view/momodu-manuel/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      },
                    );
                  else
                    return GestureDetector(
                      child: Image.asset("assets/images/team_banner_2.png"),
                      onTap: () async {
                        final url = "https://sites.google.com/view/momodu-intro/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      },
                    );
                },
              )
              else CarouselSlider.builder(
                itemCount: 2,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  reverse: false,
                  viewportFraction:0.85,
                  //aspectRatio: 4.0,
                ),
                itemBuilder: (context, i, id){
                  //for onTap to redirect to another screen
                  if(i==0)
                    return GestureDetector(
                      child: Image.asset("assets/images/manual_banner.png"),
                      onTap: () async {
                        final url = "https://sites.google.com/view/momodu-manuel/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      },
                    );
                  else
                    return GestureDetector(
                      child: Image.asset("assets/images/team_banner_2.png"),
                      onTap: () async {
                        final url = "https://sites.google.com/view/momodu-intro/%ED%99%88";
                        if(await canLaunch(url)){
                          await launch(
                            url,forceWebView:true,
                            enableJavaScript:true,
                          );
                        }
                      },
                    );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                    child: Image.asset("assets/images/game_banner_ios.png"),
                    onTap: () {
                      Get.to(GameScreen());
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("????????????",style: Theme.of(context).textTheme.titleLarge,),
                    IconButton(
                        onPressed: () {
                          Get.to(NoticeListScreen());
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
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
                    return SizedBox(// ???????????? ?????? ??????
                      height: 130,
                      child: ListView.builder(
                        physics:NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(NoticeDetailScreen(
                                  notice: snapshot.data![index],
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
              Padding(
                padding: const EdgeInsets.only(left:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("?????? ??? ???", style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                        onPressed: () {
                          Get.to(MyPostListScreen());
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
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
                        hostInfo: '',
                        hostUni: '',
                        hostNick: '',
                        hostGrade: '')
                  ],
                  future: PostRepository().getTwoPosts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      height: 130,
                      child: ListView.builder(
                        physics:NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Get.to(
                                PostDetailScreen(
                                  post: snapshot.data![index],
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
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    ); }
              ),
            ],
          ),
        ));
  }
}
