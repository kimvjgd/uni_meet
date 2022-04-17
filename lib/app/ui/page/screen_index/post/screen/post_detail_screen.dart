import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/data/model/comment_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/data/utils/timeago_util.dart';
import '../../../../../controller/notification_controller.dart';
import '../../../../../data/model/firestore_keys.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import 'package:timeago/timeago.dart' as timeAgo;
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
          leading: BackButton(
            color: Colors.black,
          ),
          actions: [
            AuthController.to.user.value.uid == widget.post.host
                ? IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: app_systemGrey1,
                    ),
                    onPressed: () {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                                title: '모모두',
                                message: '정말 삭제하시겠습니까?',
                                okCallback: () {
                                  PostRepository.deletePost(
                                      widget.post.postKey);
                                  Get.back();
                                  Get.back();
                                  Get.put(BottomNavController())
                                      .changeBottomNav(1);
                                },
                                cancelCallback: Get.back,
                              ));
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.block,
                      color: app_systemGrey1,
                    ),
                    onPressed: () {},
                  )
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
                  child: _postContent(timeAgo.format(widget.post.createdDate!))),
              Divider(
                thickness: 0.5,
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
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                      hintText: '댓글을 남겨주세요..',
                      hintStyle: TextStyle(color: app_systemGrey4),
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
                                        KEY_COMMENT_HOSTKEY:
                                            AuthController.to.user.value.uid,
                                        KEY_COMMENT_HOSTINFO:
                                          '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}_${AuthController.to.user.value.localImage}',
                                        KEY_COMMENT_CONTENT:
                                            _commentController.text,
                                        KEY_COMMENT_COMMENTTIME: DateTime.now()
                                      });

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

  // void onPress() async {
  //   CommentModel comment = CommentModel(
  //     hostKey: AuthController.to.user.value.uid,
  //     hostInfo: '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}',
  //     content: CommentController.to.commentTextController.text,
  //     commentTime: DateTime.now(),
  //   );
  //   await commentRepository.createNewComment(
  //       widget.post.postKey, comment.toMap());
  //   // 화면 새로고침
  //   CommentController.to.commentTextController.clear();
  //   setState(() {});
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
    widget.post.hostUni!+' ' + widget.post.hostGrade!+'학번 ' + widget.post.hostNick!+' ',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
            decoration: BoxDecoration(
                color: Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(2.0)),
            child: Text(
              ' 외 ${widget.post.headCount! - 1}명 ',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Column _postContent(String cuteDong) {
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
        Container(child: _hostProfile(),),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
              cuteDong
            // DateFormat.Md().add_Hm().format(widget.post.createdDate!),
          ),
        ),
        Container(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: '장소 ', style: TextStyle(color: app_systemGrey1)),
            TextSpan(
                text: widget.post.place.toString(),
                style: TextStyle(color: Colors.black)),
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
          print(snapshot.connectionState);
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
            return Column(
              children: [
                Container(child: Text(snapshot.error.toString())),
              ],
            );
          } else
            return Container();
        });
  }
}
