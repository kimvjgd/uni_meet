import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/ui/page/screen_index/widgets/profile_widget.dart';
import '../../../../../data/model/chatroom_model.dart';
import '../../../../../data/model/comment_model.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../../data/repository/chat_repository.dart';
import '../../message_popup.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final PostModel post;

  const CommentItem({required this.comment, required this.post, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(AlertDialog(
                        title: SizedBox(),
                        content: ProfileWidget(
                            university: comment.hostInfo!.split('_')[0],
                            grade: comment.hostInfo!.split('_')[1],
                            nickname: comment.hostInfo!.split('_')[2],
                            localImage: comment.hostInfo!.split('_')[3]),
                      ));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.face), // localimage는 [3] 나중에 프로필에 넣을예정
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${comment.hostInfo!.split('_')[0]} ${comment.hostInfo!.split('_')[1]} ${comment.hostInfo!.split('_')[2]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                                DateFormat.Md()
                                    .add_Hm()
                                    .format(comment.commentTime!),
                                style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    comment.content.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              )),
          AuthController.to.user.value.uid == post.host
              ? Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    child: Text("채팅 신청"),
                    onPressed: () {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                                title: "채팅 신청",
                                message: '신청하시겠습니까?',
                                okCallback: () async {
                                  if (comment.hostKey != null &&
                                      comment.hostKey != '') {
                                    await ChatRepository().createNewChatroom(
                                        ChatroomModel(
                                            allUser: [
                                              post.host,
                                              comment.hostKey
                                            ],
                                            createDate: DateTime.now(),
                                            postKey: post.postKey,
                                            headCount: post.headCount,
                                            postTitle: post.title,
                                            place: post.place,
                                            lastMessage: '',
                                            chatroomId: '',
                                            lastMessageTime: DateTime.now()),
                                        post.host.toString(),
                                        comment.hostKey.toString());
                                  } else {
                                    Get.snackbar("알림", "탈퇴한 회원입니다.");
                                  }
                                  Get.back();
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => AlertDialog(
                                            title: Text("채팅방이 생성되었습니다"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    Get.back();
                                                    Get.put(BottomNavController())
                                                        .changeBottomNav(2);
                                                  },
                                                  child: Text("채팅룸 바로 가기"))
                                            ],
                                          ));
                                },
                                cancelCallback: Get.back,
                              ));
                    },
                  ))
              : AuthController.to.user.value.uid == comment.hostKey
                  ? IconButton(
                      icon: Icon(Icons.cancel_outlined),
                      onPressed: () {
                        showDialog(
                            context: Get.context!,
                            builder: (context) => MessagePopup(
                                  title: '모모두',
                                  message: '삭제하시겠습니까?',
                                  okCallback: () {
                                    commentRepository.deleteComment(
                                        post.postKey, comment.commentKey!);
                                    Get.back();
                                  },
                                  cancelCallback: Get.back,
                                ));
                      },
                    )
                  : Container()
        ],
      ),
    );
  }
}
