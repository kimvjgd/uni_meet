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
import '../../../../../data/utils/timeago_util.dart';
import '../../../../components/app_color.dart';
import '../../../account/widget/big_button.dart';
import '../../message_popup.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;
  final PostModel post;

  const CommentItem({required this.comment, required this.post, Key? key})
      : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late FocusNode myFocusNode;
  TextEditingController babyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(AlertDialog(
                  title: SizedBox(),
                  content: ProfileWidget(
                      university: widget.comment.hostInfo!.split('_')[0],
                      grade: widget.comment.hostInfo!.split('_')[1] + '학번',
                      mbti: widget.comment.hostInfo!.split('_')[4],
                      gender: widget.comment.hostInfo!.split('_')[5],
                      nickname: widget.comment.hostInfo!.split('_')[2],
                      localImage: widget.comment.hostInfo!.split('_')[3]),
                ));
              },
              child: Text(
                widget.comment.hostInfo!.split('_')[0] +
                    widget.comment.hostInfo!.split('_')[1] +
                    '학번' +
                    widget.comment.hostInfo!.split('_')[2],
                style: TextStyle(color: app_systemGrey1),
              ),
            ),
            Row(
              children: [
                Text(
                  TimeAgo.timeCustomFormat(widget.comment.commentTime!),
                  style: TextStyle(fontSize: 12, color: app_systemGrey1),
                ),
                AuthController.to.user.value.uid == widget.comment.hostKey
                    ? IconButton(
                        padding: EdgeInsets.all(0),
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
                                          widget.post.postKey,
                                          widget.comment.commentKey!);
                                      Get.back();
                                    },
                                    cancelCallback: Get.back,
                                  ));
                        },
                      )
                    : AuthController.to.user.value.uid == widget.post.host
                        ? IconButton(
                            padding: EdgeInsets.only(top: 3),
                            icon: ImageIcon(AssetImage(
                                "assets/images/icons/chat_icon.png")),
                            iconSize: 20,
                            color: app_systemGrey1,
                            onPressed: () {
                              showDialog(
                                  context: Get.context!,
                                  builder: (context) => MessagePopup(
                                        title: "채팅 신청",
                                        message: '신청하시겠습니까?',
                                        okCallback: () async {
                                          if (widget.comment.hostKey != null &&
                                              widget.comment.hostKey != '') {
                                            if (await CommentRepository()
                                                .checkCommentPossible(
                                                    widget.comment.hostKey!)) {
                                              await ChatRepository()
                                                  .createNewChatroom(
                                                      ChatroomModel(
                                                          allUser: [
                                                            widget.post.host,
                                                            widget
                                                                .comment.hostKey
                                                          ],
                                                          allToken: [
                                                            widget.post
                                                                .hostpushToken
                                                                .toString(),
                                                            widget.comment
                                                                .hostPushToken
                                                                .toString()
                                                          ],
                                                          createDate:
                                                              DateTime.now(),
                                                          postKey: widget
                                                              .post.postKey,
                                                          headCount: widget
                                                              .post.headCount,
                                                          postTitle:
                                                              widget.post.title,
                                                          place:
                                                              widget.post.place,
                                                          lastMessage: '',
                                                          chatroomId: '',
                                                          lastMessageTime:
                                                              DateTime.now()),
                                                      widget.post.host
                                                          .toString(),
                                                      widget.comment.hostKey
                                                          .toString());

                                              FirebaseFirestore.instance
                                                  .collection(
                                                      COLLECTION_CHATROOMS)
                                                  .where(KEY_CHATROOM_ALLUSER,
                                                      isEqualTo: [
                                                        widget.post.host,
                                                        widget.comment.hostKey
                                                      ])
                                                  .get()
                                                  .then((value) {
                                                    value.docs
                                                        .forEach((element) {
                                                      print("채팅 룸 키" +
                                                          element.id);

                                                      NewsController.to.newchat(
                                                          widget.post.title
                                                              .toString(),
                                                          widget.comment.hostKey
                                                              .toString(),
                                                          element.id
                                                              .toString());
                                                      // NewsRepository()
                                                      //     .createChatOpenNews(
                                                      //         post.title.toString(),
                                                      //         comment.hostKey
                                                      //             .toString(),
                                                      //         element.id.toString());
                                                    });
                                                  });

                                              //푸시 알림
                                              await Get.put(
                                                      NotificationController())
                                                  .SendNewChatNotification(
                                                      info:
                                                          widget.post.hostUni
                                                                  .toString() +
                                                              " " +
                                                              widget.post
                                                                  .hostGrade
                                                                  .toString() +
                                                              "학번 " +
                                                              widget
                                                                  .post.hostNick
                                                                  .toString(),
                                                      receiver_token: widget
                                                          .comment.hostPushToken
                                                          .toString());
                                            } else {
                                              showDialog(
                                                  context: Get.context!,
                                                  builder: (context) =>
                                                      MessagePopup(
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
                                                                .changeBottomNav(
                                                                    2);
                                                          },
                                                          child:
                                                              Text("채팅룸 바로 가기"))
                                                    ],
                                                  ));
                                        },
                                        cancelCallback: Get.back,
                                      ));
                            },
                          )
                        : Container()
              ],
            ),
          ],
        ),
        Text(
          widget.comment.content!,
          maxLines: null,
        ),
        //대댓글 ui 만 가려놓음
        // FutureBuilder(
        //     future: commentRepository
        //         .loadBabyCommentList(widget.comment.commentKey!),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData) {
        //         return snapshot.data.length == 0
        //         ? SizedBox()
        //         : SizedBox(
        //           height: 200,
        //                 child: ListView.builder(
        //                   itemCount: 4,
        //                   itemBuilder: (context,index){
        //                     var content = snapshot.data![index]
        //                         .cast<String, dynamic>()['content']
        //                         .toString();
        //                     var writer = snapshot.data![index]
        //                         .cast<String, dynamic>()['writer']
        //                         .toString();
        //                     print("프린트"+content + writer);
        //                     return ListTile(
        //                       leading:Icon(
        //                         Icons.subdirectory_arrow_right,
        //                         size: 19,
        //                         color: app_systemGrey1,
        //                       ),
        //                       title: Text(writer,style: TextStyle(color: Colors.black),),
        //                       subtitle: Text(content),
        //                     );
        //                   },
        //                 ),
        //               );
        //       } else
        //         return SizedBox();
        //     }),
        // // : Text(
        // //     '비밀 댓글입니다.',
        // //     maxLines: null,
        // //     style: TextStyle(color: Colors.grey[500]),
        // //   ),,
        // AuthController.to.user.value.uid == widget.post.host ||
        //         AuthController.to.user.value.uid == widget.comment.hostKey
        //     ? Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.subdirectory_arrow_right,
        //               size: 19,
        //               color: app_systemGrey1,
        //             ),
        //             Expanded(
        //               child: TextFormField(
        //                 focusNode: myFocusNode,
        //                 autofocus: true,
        //                 controller: babyController,
        //                 decoration: InputDecoration(
        //                   fillColor: Colors.grey[50],
        //                   filled: true,
        //                   hintText: "답글을 입력하세요.",
        //                   hintStyle:
        //                       TextStyle(fontSize: 12, color: app_systemGrey1),
        //                   border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(50),
        //                       borderSide: BorderSide(
        //                           width: 0, color: Colors.transparent)),
        //                   enabledBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(50),
        //                       borderSide: BorderSide(
        //                           width: 0, color: Colors.transparent)),
        //                   focusedBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(50),
        //                       borderSide: BorderSide(
        //                           width: 0, color: Colors.transparent)),
        //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
        //                   suffixIcon: IconButton(
        //                     onPressed: () {
        //                       if (babyController.text.trim() != '') {
        //                         showDialog(
        //                             context: Get.context!,
        //                             builder: (BuildContext context) {
        //                               return MessagePopup(
        //                                 title: "답글 등록",
        //                                 message: '등록하시겠습니까?',
        //                                 okCallback: () async {
        //                                   AuthController.to.user.value.uid ==
        //                                           widget.post.host
        //                                       ? await commentRepository
        //                                           .createBabyComment(
        //                                               widget
        //                                                   .comment.commentKey!,
        //                                               babyController.text,
        //                                               true)
        //                                       : await commentRepository
        //                                           .createBabyComment(
        //                                               widget
        //                                                   .comment.commentKey!,
        //                                               babyController.text,
        //                                               false);
        //                                   Get.back();
        //                                 },
        //                                 cancelCallback: Get.back,
        //                               );
        //                             });
        //                       }
        //                     },
        //                     icon: ImageIcon(AssetImage(
        //                         "assets/images/icons/send_chat_icon.png")),
        //                     iconSize: 15,
        //                   ),
        //                 ),
        //                 style: TextStyle(fontSize: 12),
        //                 maxLines: 1,
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : Container()
      ],
    );
  }
}
