import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/ui/widgets/input_bar.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/widget/chatText.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;

  ChatroomScreen({required this.chatroomKey, Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ChatController.to.getOldMessages();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.chatroomKey, style: TextStyle(color: Colors.black),),
          actions: [IconButton(icon: Icon(Icons.copy,color: Colors.black,), onPressed: () async{
          await FlutterClipboard.copy(widget.chatroomKey);
        },)],),
        body: SafeArea(
          child: Column(
            children: [
              _postInfo(),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Obx(() => ListView.separated(
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      bool isMine =
                          ChatController.to.chat_chatList[index].writer!.split('_')[2] ==
                              AuthController.to.user.value.nickname;
                      return ChatText(
                        size: _size,
                        isMine: isMine,
                        chatModel: ChatController.to.chat_chatList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 3,
                      );
                    },
                    itemCount: ChatController.to.chat_chatList.length)),
              )),
              InputBar(
                  textEditingController: _chatController,
                  icon: Icon(Icons.send),
                  onPress: onPress,
                  hintText: '메세지를 입력하세요.')
            ],
          ),
        ),
      );
    });
  }

  Future<void> onPress() async {
    ChatModel chat = ChatModel(
      writer: '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}_${AuthController.to.user.value.localImage}',
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
