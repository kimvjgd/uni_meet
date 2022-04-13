import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/model/comment_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/ui/components/input_bar.dart';

class PostDetailScreen extends StatefulWidget {

  // commentController 쓰려다가 귀찮아서 그냥 넘김 나중에 유지보수때 건드릴 예정...ㅋㅋ

  final PostModel post;

  PostDetailScreen({required this.post, Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<CommentModel>>(
          future: commentRepository.loadCommentList(widget.post.postKey),
          initialData: [
            CommentModel(
                host: 'nothing',
                content: 'nothing',
                commentTime: DateTime.now())
          ],
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _intro();
                      } else if (index == 1) {
                        return _content();
                      } else {
                        return _comment(snapshot);
                      }
                    },
                    itemCount: 3,
                  ),
                ),
                widget.post.host != AuthController.to.user.value.uid ? InputBar(
                    textEditingController: CommentController.to.commentTextController,
                    icon: Icon(CupertinoIcons.arrow_up_circle),
                    onPress: onPress,
                    hintText: "댓글을 남겨주세요."):SizedBox.shrink()
              ],
            );
          }),
    );
  }

  void onPress() async {
    CommentModel comment = CommentModel(
      host: AuthController.to.user.value.uid,
      content: CommentController.to.commentTextController.text,
      commentTime: DateTime.now(),
    );
    await commentRepository.createNewComment(
        widget.post.postKey, comment.toMap());
    // 화면 새로고침

    CommentController.to.commentTextController.clear();
    setState(() {

    });
  }

  Column _comment(AsyncSnapshot<List<CommentModel>> snapshot) {
    return Column(
      children: List.generate(
          snapshot.data!.length,
          (index) => SizedBox(
              width: double.infinity,
              child: GestureDetector(
                  onTap: () {
                    snapshot.data![index].host != AuthController.to.user.value.uid ? showDialog(
                        context: Get.context!,
                        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            //Dialog Main Title
                            title: Column(
                              children: <Widget>[
                                const Text("채팅하기"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "@@@님과 채팅하기",
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("채팅하기"),
                                onPressed: () async {
                                  if (AuthController.to.user.value.uid ==
                                          widget.post.host &&
                                      snapshot.data![index].host != null &&
                                      snapshot.data![index].host != '') {
                                    await ChatRepository().createNewChatroom(
                                      ChatroomModel(
                                          allUser: [
                                            widget.post.host!,
                                            snapshot.data![index].host!
                                          ],
                                          createDate: DateTime.now(),
                                          postKey: widget.post.postKey,
                                          headCount: widget.post.headCount,
                                          postTitle: widget.post.title,
                                          lastMessage: '',
                                          chatId: '',
                                          lastMessageTime: DateTime.now()),
                                      AuthController.to.user.value.uid!,
                                      snapshot.data![index]
                                          .host!, // 탈퇴했을때... 경우를 고려해줘야함
                                    );
                                  } else {
                                    Get.snackbar("알림", "회원이 탈퇴했습니다.");
                                  }

                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text("취소"),
                                onPressed: () {
                                  Get.back();
                                },
                              )
                            ],
                          );
                        }):print('본인이 작성');
                  },
                  child: Card(child: Row(
                    children: [
                      Icon(Icons.person),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(snapshot.data![index].host!,overflow: TextOverflow.ellipsis,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(snapshot.data![index].content!),
                          ),
                        ],
                      ),
                    ],
                  ))))),
    );
  }

  Container _content() {
    return Container(
      child: Column(
        children: [
          Text(
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      color: Colors.blue,
    );
  }

  Container _intro() {
    return Container(
      child: Column(
        children: [
          Text(
            'Intro',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Intro',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      color: Colors.red,
    );
  }
}
