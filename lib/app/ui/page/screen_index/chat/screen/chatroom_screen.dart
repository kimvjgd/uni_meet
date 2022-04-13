import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/ui/components/input_bar.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/widget/chatText.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;

  ChatroomScreen({required this.chatroomKey, Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              _postInfo(),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Obx(() => ListView.separated(
                    reverse: true,
                    itemBuilder: (context, index) {
                      bool isMine =
                          ChatController.to.chat_chatList.value[index].writer ==
                              AuthController.to.user.value.uid;
                      return ChatText(
                        size: _size,
                        isMine: isMine,
                        chatModel: ChatController.to.chat_chatList.value[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 3,
                      );
                    },
                    itemCount: ChatController.to.chat_chatList.value.length)),
              )),
              InputBar(textEditingController: _chatController, icon: Icon(Icons.send), onPress: onPress, hintText: '메세지를 입력하세요.')
            ],
          ),
        ),
      );
    });
  }
  Future<void> onPress() async {
    ChatModel chat = ChatModel(
      writer: AuthController.to.user.value.uid,
      message: _chatController.text,
      createdDate: DateTime.now(),
    ); // 여기서 에러?
    // await ChatRepository().createNewChat(widget.chatroomKey, chat);
    ChatController.to.addNewChat(chat);
    _chatController.clear();
  }

  MaterialBanner _postInfo() {
    return MaterialBanner(
        padding: EdgeInsets.zero,
        content: Column(
          children: [
            ListTile(
              leading: Icon(Icons.wysiwyg),
              title: RichText(
                text: TextSpan(
                    text: '신촌에서 3:3 술마실분?   ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '2022/04/11',
                      )
                    ]),
              ),
            )
          ],
        ),
        actions: [Container()]);
  }
}
