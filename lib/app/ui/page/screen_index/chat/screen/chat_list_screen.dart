import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/controller/chatroom_controller.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chatroom_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // ChatroomController
  Future _onRefresh() async {
    ChatroomController.to.getChatroomList();
  }

  TextEditingController _addChatKey = TextEditingController();

  @override
  void dispose() {
    _addChatKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "채팅",
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
        body: FutureBuilder<List<ChatroomModel>>(
            future: ChatRepository()
                .getMyChatList(AuthController.to.user.value.uid.toString()),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              } else {
                return ListView(
                  children: List.generate(
                      snapshot.data!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => ChatroomScreen(
                                      chatroomKey:
                                          snapshot.data![index].chatroomId!),
                                  binding: InitBinding.chatroomBinding(
                                      snapshot.data![index].chatroomId!));
                            },
                            child: Card(
                              color: Colors.white,
                              shadowColor: app_lightyellow,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                TextSpan(
                                                    text: snapshot.data![index]
                                                        .postTitle!,
                                                    style: TextStyle(
                                                        fontSize: 16,color: Colors.black)),
                                                TextSpan(text: ' '),
                                                TextSpan(
                                                    text: snapshot.data![index]
                                                        .allUser!.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            app_systemGrey1)),
                                              ])),
                                          Text(
                                              DateFormat.Hm().format(snapshot
                                                  .data![index]
                                                  .lastMessageTime!),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: app_systemGrey1)),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data![index].lastMessage!,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )).toList(),
                );
              }
            }),
        floatingActionButton: AuthController.to.user.value.auth == true
            ? FloatingActionButton(
                heroTag: 'invite',
                foregroundColor: app_deepyellow,
                backgroundColor: app_lightyellow,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                elevation: 3,
                onPressed: () {
                  showDialog(
                      context: Get.context!,
                      builder: (context) => Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    width: Get.width * 0.7,
                                    child: Column(
                                      children: [
                                        const Text(
                                          '채팅방 키를 입력하세요..',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        TextField(
                                          controller: _addChatKey,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  ChatRepository().enterExistedChatroom(_addChatKey.text);
                                                 // ChatController.to.enterRoom(_addChatKey.text);
                                                },
                                                child: Text('확인')),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                /// TODO 동현
                                                Get.back();
                                              },
                                              child: Text('취소'),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                },
                child: Icon(Icons.mail_rounded),
              )
            : FloatingActionButton(
                heroTag: 'invite',
                foregroundColor: Colors.white,
                backgroundColor: app_systemGrey3,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                elevation: 3,
                onPressed: () {
                  Get.snackbar("알림", "학교 인증을 완료해주세요 !");
                },
                child: Icon(Icons.mail_rounded)));
  }

  Widget _chatroomList() {
    return Obx(() => ListView(
          children: List.generate(
              ChatroomController.to.chatroomList.length,
              (index) => GestureDetector(
                    onTap: () {
                      Get.to(
                          () => ChatroomScreen(
                              chatroomKey: ChatroomController
                                  .to.chatroomList[index].chatroomId!),
                          binding: InitBinding.chatroomBinding(
                              ChatroomController
                                  .to.chatroomList[index].chatroomId!));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text(ChatroomController
                              .to.chatroomList[index].postTitle!),
                          Text(
                            ChatroomController
                                .to.chatroomList[index].lastMessageTime
                                .toString(),
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
        ));
  }
}
