import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_color,
        centerTitle: true,
        title: Text('채팅'),
      ),
      body: FutureBuilder<List<ChatroomModel>>(
          future: ChatRepository().getMyChatList(AuthController.to.user.value.uid!),
          builder: (context, snapshot){
            if(snapshot.data==null){
              return CircularProgressIndicator();
            }else
             {
              return ListView(
                children: List.generate(
                    snapshot.data!.length,
                        (index) =>
                        GestureDetector(
                          onTap: () {
                            Get.to(
                                    () =>
                                    ChatroomScreen(
                                        chatroomKey:
                                        snapshot.data![index].chatId!),
                                binding: InitBinding.chatroomBinding(
                                    snapshot.data![index]
                                        .chatId!));
                          },
                          child: Card(
                            color: Colors.deepPurpleAccent,
                            child: Column(
                              children: [
                                Text(snapshot.data![index]
                                    .postTitle!),
                                Text(
                                  snapshot.data![index]
                                      .lastMessage!,
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )).toList(),
              );
            }          }),
    );
  }




  Widget _chatroomList() {
    return Obx(() => ListView(
          children: List.generate(
              ChatroomController.to.chatroomList.length,
              (index) => GestureDetector(
                    onTap: () {
                      Get.to(
                          () => ChatroomScreen(
                              chatroomKey:
                                  ChatroomController.to.chatroomList[index].chatId!),
                          binding: InitBinding.chatroomBinding(
                              ChatroomController.to.chatroomList[index].chatId!));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text(ChatroomController.to.chatroomList[index].postTitle!),
                          Text(
                            ChatroomController.to.chatroomList[index].lastMessageTime
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
