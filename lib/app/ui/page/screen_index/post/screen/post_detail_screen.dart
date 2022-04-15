import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/controller/post_controller.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/model/comment_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/components/input_bar.dart';

import '../../../../../controller/notification_controller.dart';
import '../../../../../data/model/firestore_keys.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import 'package:intl/intl.dart';

import '../widget/comment_item.dart';

class PostDetailScreen extends StatefulWidget {

  final PostModel post;
  PostDetailScreen({required this.post, Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String writer_token =
        'fdk-eOCoStGcgbfdH5zlKW:APA91bGKe9kX4-WVQugGrVRQ9XfcGUOVLZecXc2TmYRUuvWX-HQIIe8IGNIgYDFJDeKdgZwQwji3N_otI7kpP2KvRTvhr2y0OKFl1jqvf9xy36fNjtjUFKx-z2y1oEDb48BWthivCupn';

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black,),
          actions:[
            AuthController.to.user.value.uid == widget.post.host
                ? IconButton(
              icon: Icon(Icons.delete,color: app_systemGrey1,)
              ,onPressed: (){
              showDialog(
                  context: Get.context!,
                  builder: (context) => MessagePopup(
                    title: '모모두',
                    message: '정말 삭제하시겠습니까?',
                    okCallback: () {
                      PostRepository.deletePost(widget.post.postKey);
                      Get.back();
                      Get.back();
                      Get.put(BottomNavController()).changeBottomNav(1);
                    },
                    cancelCallback: Get.back,
                  )
              );

            },)
                : IconButton(icon: Icon(Icons.block,color: app_systemGrey1,),onPressed: (){},)
          ],
        ),
        body: Container(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          height: _size.height,
          width: _size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _postContent()),
              Divider(
                thickness: 1,
                color: divider,
              ),
              _commentContent(),
            ],
          ),
        ),
        bottomSheet: widget.post.host != AuthController.to.user.value.uid
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    border:UnderlineInputBorder(borderSide:BorderSide.none),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                      hintText: '댓글을 남겨주세요..',
                      hintStyle: TextStyle(color: app_systemGery4),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          showDialog(
                              context: Get.context!,
                              builder: (context) => MessagePopup(
                                    title: '시스템',
                                    message: "댓글을 작성하시겠습니까?",
                                    okCallback: () async {
                                      await commentRepository.createNewComment(
                                          widget.post.postKey, {
                                            KEY_COMMENT_HOST: AuthController.to.user.value.uid,
                                            KEY_COMMENT_CONTENT: _commentController.text,
                                            KEY_COMMENT_COMMENTTIME: DateTime.now()
                                      });
                                      print(widget.post.title);
                                      await Get.put(NotificationController())
                                          .NewCommentNotification(
                                              title:
                                                  widget.post.title.toString(),
                                              receiver_token: writer_token);
                                      Get.back();
                                      _commentController.clear();
                                    },
                                    cancelCallback: Get.back,
                                  ));
                        },
                      )),
                ),
              )
            : SizedBox.shrink());
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
   // setState(() {});
  }

  // Column _comment(AsyncSnapshot<List<CommentModel>> snapshot) {
  //   return Column(
  //     children: List.generate(
  //         snapshot.data!.length,
  //         (index) => SizedBox(
  //             width: double.infinity,
  //             child: GestureDetector(
  //                 onTap: () {
  //                   snapshot.data![index].host !=
  //                           AuthController.to.user.value.uid
  //                       ? showDialog(
  //                           context: Get.context!,
  //                           //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
  //                           barrierDismissible: false,
  //                           builder: (BuildContext context) {
  //                             return AlertDialog(
  //                               // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10.0)),
  //                               //Dialog Main Title
  //                               title: Column(
  //                                 children: <Widget>[
  //                                   const Text("채팅하기"),
  //                                 ],
  //                               ),
  //                               //
  //                               content: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     "@@@님과 채팅하기",
  //                                   ),
  //                                 ],
  //                               ),
  //                               actions: <Widget>[
  //                                 TextButton(
  //                                   child: const Text("채팅하기"),
  //                                   onPressed: () async {
  //                                     if (AuthController.to.user.value.uid ==
  //                                             widget.post.host &&
  //                                         snapshot.data![index].host != null &&
  //                                         snapshot.data![index].host != '') {
  //                                       await ChatRepository()
  //                                           .createNewChatroom(
  //                                         ChatroomModel(
  //                                             allUser: [
  //                                               widget.post.host!,
  //                                               snapshot.data![index].host!
  //                                             ],
  //                                             createDate: DateTime.now(),
  //                                             postKey: widget.post.postKey,
  //                                             headCount: widget.post.headCount,
  //                                             postTitle: widget.post.title,
  //                                             place: widget.post.place,
  //                                             lastMessage: '',
  //                                             chatId: '',
  //                                             lastMessageTime: DateTime.now()),
  //                                         AuthController.to.user.value.uid!,
  //                                         snapshot.data![index]
  //                                             .host!, // 탈퇴했을때... 경우를 고려해줘야함
  //                                       );
  //                                     } else {
  //                                       Get.snackbar("알림", "회원이 탈퇴했습니다.");
  //                                     }
  //
  //                                     Get.back();
  //                                   },
  //                                 ),
  //                                 TextButton(
  //                                   child: const Text("취소"),
  //                                   onPressed: () {
  //                                     Get.back();
  //                                   },
  //                                 )
  //                               ],
  //                             );
  //                           })
  //                       : print('본인이 작성');
  //                 },
  //                 child: Card(
  //                     child: Row(
  //                   children: [
  //                     Icon(Icons.person),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(4.0),
  //                           child: Text(
  //                             snapshot.data![index].host!,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(4.0),
  //                           child: Text(snapshot.data![index].content!),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ))))),
  //   );
  // }
  //
  // Container _content() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Text(
  //           '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
  //           '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
  //           '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내',
  //           style: TextStyle(fontSize: 30),
  //         ),
  //       ],
  //     ),
  //     color: Colors.blue,
  //   );
  // }
  //
  // Container _intro() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Text(
  //           'Intro',
  //           style: TextStyle(fontSize: 30),
  //         ),
  //         Text(
  //           'Intro',
  //           style: TextStyle(fontSize: 30),
  //         ),
  //       ],
  //     ),
  //     color: Colors.red,
  //   );
  // }

  Row _hostProfile() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          child: CircleAvatar(
            backgroundColor: Colors.green,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '모모대 18학번 닉네임 ',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(2.0)),

            child: Text(' 외 ${widget.post.headCount! - 1}명 ',style: TextStyle(color: Colors.white),))
      ],
    );
  }

  Column _postContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            widget.post.title.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _hostProfile(),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            DateFormat.Md().add_Hm().format(widget.post.createdDate!),
          ),
        ),
        Container(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: '장소 ', style: TextStyle(color: app_systemGrey1)),
            TextSpan(text: widget.post.place.toString(),style: TextStyle(color: Colors.black)),
          ])),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(widget.post.content.toString(), maxLines: null),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  FutureBuilder _commentContent() {
    return FutureBuilder(
        future: commentRepository.loadCommentList(widget.post.postKey),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   //return LinearProgressIndicator();
          //   return Container();
          // }
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? Center(
                    child: Text("작성된 댓글이 없습니다!"),
                  )
                : Expanded(
                    child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 60),
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CommentItem(
                          comment: snapshot.data[index], post: widget.post);
                    },
                  ));
          } else if (snapshot.hasError) {
            return Container(child: Text(snapshot.error.toString()));
          } else
            return Container();
        });
  }

}
