import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/news_controller.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/ui/page/screen_index/widgets/profile_widget.dart';
import '../../../../../controller/notification_controller.dart';
import '../../../../../data/model/chatroom_model.dart';
import '../../../../../data/model/comment_model.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../../data/repository/chat_repository.dart';
import '../../../../../data/repository/news_repository.dart';
import '../../../../components/app_color.dart';
import '../../../account/widget/big_button.dart';
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
          Expanded(flex: 4, child: _contents()),
          AuthController.to.user.value.uid == post.host
              ? Expanded(
                  flex: 2,
                  child: BigButton(
                    btnText: "채팅 신청",
                    onPressed: () {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                                title: "채팅 신청",
                                message: '신청하시겠습니까?',
                                okCallback: () async {
                                  if (comment.hostKey != null &&
                                      comment.hostKey != '') {
                                    if (await CommentRepository().checkCommentPossible(comment.hostKey!)) {
                                      await ChatRepository().createNewChatroom(
                                          ChatroomModel(
                                              allUser: [
                                                post.host,
                                                comment.hostKey
                                              ],
                                              allToken: [
                                                post.hostpushToken.toString(),
                                                comment.hostPushToken.toString()
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

                                      FirebaseFirestore.instance
                                          .collection(COLLECTION_CHATROOMS)
                                          .where(KEY_CHATROOM_ALLUSER,
                                              isEqualTo: [
                                                post.host,
                                                comment.hostKey
                                              ])
                                          .get()
                                          .then((value) {
                                            value.docs.forEach((element) {
                                              print("채팅 룸 키" + element.id);

                                              NewsController.to.newchat(
                                                  post.title.toString(),
                                                  comment.hostKey
                                                      .toString(),
                                                  element.id.toString());
                                              // NewsRepository()
                                              //     .createChatOpenNews(
                                              //         post.title.toString(),
                                              //         comment.hostKey
                                              //             .toString(),
                                              //         element.id.toString());
                                            });
                                          });

                                      //푸시 알림
                                      await Get.put(NotificationController())
                                          .SendNewChatNotification(
                                              info: post.hostUni.toString() +
                                                  " " +
                                                  post.hostGrade.toString() +
                                                  "학번 " +
                                                  post.hostNick.toString(),
                                              receiver_token: comment
                                                  .hostPushToken
                                                  .toString());
                                    } else {
                                      showDialog(
                                          context: Get.context!,
                                          builder: (context) => MessagePopup(
                                                title: '알림',
                                                message: '탈퇴한 회원입니다.',
                                                okCallback: () {
                                                  Get.back();
                                                },
                                              ));
                                    }
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
                      icon: Icon(Icons.clear),
                      iconSize: 15,
                      color: app_systemGrey1,
                      onPressed: () {
                        showDialog(
                            context: Get.context!,
                            builder: (context) => MessagePopup(
                                  title: '댓글 삭제',
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

  Column _contents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Get.dialog(AlertDialog(
              title: SizedBox(),
              content: ProfileWidget(
                  university: comment.hostInfo!.split('_')[0],
                  grade: comment.hostInfo!.split('_')[1] + '학번',
                  mbti: comment.hostInfo!.split('_')[4],
                  gender: comment.hostInfo!.split('_')[5],
                  nickname: comment.hostInfo!.split('_')[2],
                  localImage: comment.hostInfo!.split('_')[3]),
            ));
          },
          child: Text(
            comment.hostInfo!.split('_')[0]+comment.hostInfo!.split('_')[1] + '학번'+comment.hostInfo!.split('_')[2],
            style: TextStyle(fontWeight: FontWeight.bold, color: app_red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: (comment.hostKey==AuthController.to.user.value.uid || post.host==AuthController.to.user.value.uid)?Text(
            comment.content!,
            maxLines: null,
          ):Text(
            '비밀 댓글입니다.',
            maxLines: null,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        Text(
          DateFormat.Md().add_Hm().format(comment.commentTime!),
          style: TextStyle(fontSize: 12, color: app_systemGrey1),
        ),
      ],
    );
  }
}
