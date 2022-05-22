import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/invite_help.dart';
import 'package:uni_meet/app/ui/page/screen_index/index_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/message_popup.dart';
import 'package:uni_meet/app/ui/page/screen_index/widgets/profile_widget.dart';
import 'package:uni_meet/app/ui/widgets/input_bar.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/widget/chatText.dart';

import '../../../../../controller/chatroom_controller.dart';
import '../../../../../controller/notification_controller.dart';
import '../../../../components/app_color.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;

  ChatroomScreen({required this.chatroomKey,Key? key}) : super(key: key);

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

    // setState(() {
    //   AuthController.to.user.refresh();
    //   ChatController.to.chat_chatList.refresh();
    // });

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.grey[800],
            ),
            iconTheme: IconThemeData(color: Colors.grey[800]),
            actions: [],
          ),
          endDrawer: SafeArea(
            child: Drawer(
                child: Column(
                  children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Text("대화상대",style:TextStyle(fontSize: 15),),
                  ),
                ),
                Divider(thickness: 1,color: divider,),
                // Expanded(child: FutureBuilder(
                //   future: ChatRepository.getChatterInfo(ChatController.to.chat_chatroomModel.value.allUser!),
                //     builder: (context, snapshot) {
                //   return Container();
                // },
                // )),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: ChatController.to.chat_chatroomModel.value.allUser!.length,
                //     itemBuilder: (BuildContext context,int index){
                //       return ListTile(
                //         onTap: ()async {await ChatRepository.getChatterInfo(widget.chatroomKey);},
                //         title:Text("닉네임",style: TextStyle(fontSize: 10),)
                //       );
                //     },
                //   )
                // ),
                Obx(() => Expanded(
                        child: ListView.builder(
                      itemCount: ChatController.to.chatterInfo.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chatterInfo = ChatController.to.chatterInfo[index];
                        return ListTile(
                            onTap: () async {
                              if(chatterInfo.gender=='Gender.MAN'){
                                chatterInfo.gender = '남자';
                              }else if(chatterInfo.gender=='Gender.WOMAN'){
                                chatterInfo.gender = '여자';
                              }
                              Get.dialog(AlertDialog(
                                title: SizedBox(),
                                content: ProfileWidget(
                                    university: chatterInfo.university!,
                                    grade: '${chatterInfo.grade} 학번',
                                    mbti: chatterInfo.mbti!,
                                    gender: chatterInfo.gender!,
                                    nickname: chatterInfo.nickname!,
                                    localImage: chatterInfo.localImage!),
                              ));
                            },
                            leading: ExtendedImage.asset(
                              'assets/images/momo${ChatController.to.chatterInfo[index].localImage}.png',
                            ),
                            title: Text(
                              ChatController.to.chatterInfo[index].nickname!,
                              style: TextStyle(fontSize: 14),
                            ));
                      },
                    ))),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("초대하기"),
                                          content: Text(
                                            "복사된 코드를 친구에게 전달해주세요! \n채팅방 리스트 오른쪽 하단 버튼을 통해 입장하실 수 있습니다.",
                                            textAlign: TextAlign.center,
                                          ),

                                          actions: [
                                            Row(
                                              children: [
                                                IconButton(onPressed: (){
                                                  Get.to(InviteHelp());
                                                }, icon: Icon(Icons.help_outline)),
                                                TextButton(
                                                    onPressed: () async {
                                                      await FlutterClipboard.copy(
                                                          widget.chatroomKey);
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "복사하기",
                                                    )),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "초대하기",
                                  style: TextStyle(color: Colors.white),
                                )),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        child: Text("신고하기"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessagePopup(
                                  title: "신고하기",
                                  message:
                                  "정말 채팅방을 신고하시겠습니까? 신고 후 2~3일 내로 운영진의 적절한 조치가 이루어질 예정입니다.\n특정 사용자의 신고/차단은 상대방의 프로필 클릭 후 가능합니다. ",
                                  okCallback: () async {
                                    await FirebaseStorage.instance
                                        .ref('report/chatroom/' +
                                        widget.chatroomKey.toString())
                                        .putString(DateTime.now().toString());
                                    //일단.. 귀찮으니..
                                    Get.back();
                                    Get.snackbar("알림", "신고처리가 완료되었습니다.");
                                  },
                                  cancelCallback: () {
                                    Get.back();
                                  },
                                );
                              });
                        }),
                    Container(height: 20,width: 1,color: divider,),
                    TextButton(
                      child: Text("나가기"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("나가기"),
                                content: Text("채팅방을 나가시겠습니까?"),
                                actions: [
                                  IconButton(
                                      onPressed: () async {
                                        await ChatRepository()
                                            .exitChatroom(widget.chatroomKey);
                                        // await ChatController.to.exitRoom(widget.chatroomKey);
                                        Get.offAll(IndexScreen());
                                      },
                                      icon: Icon(Icons.exit_to_app))
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),SizedBox(height: 8,)

              ],
            )),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // _postInfo(),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: Obx(() => ListView.separated(
                      reverse: true,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        bool isMine = ChatController
                                .to.chat_chatList[index].writer!
                                .split('_')[2] ==
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
                    onPress: onPress,
                    hintText: '메세지를 입력하세요.')
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> onPress() async {
    ChatModel chat = ChatModel(
      writer:
          '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}_${AuthController.to.user.value.localImage}_${AuthController.to.user.value.mbti}_${AuthController.to.user.value.gender}',
      message: _chatController.text,
      createdDate: DateTime.now(),
    ); // 여기서 에러?
    // await ChatRepository().createNewChat(widget.chatroomKey, chat);
    if (_chatController.text.trim() != '') ChatController.to.addNewChat(chat);
    _chatController.clear();

    Get.put(NotificationController()).SendNewChat(
        Sender: AuthController.to.user.value.nickname.toString(),
        Sender_token: AuthController.to.user.value.token.toString(),
        receiver_token: ChatController.to.chat_chatroomModel.value.allToken);
  }

// MaterialBanner _postInfo() {
//   return MaterialBanner(
//       padding: EdgeInsets.zero,
//       content: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.wysiwyg),
//             title: RichText(
//               text: TextSpan(
//                   text: '신촌에서 3:3 술마실분?   ',
//                   style: TextStyle(color: Colors.black),
//                   children: [
//                     TextSpan(
//                       text: '2022/04/11',
//                     )
//                   ]),
//             ),
//           )
//         ],
//       ),
//       actions: [Container()]);
// }
}
