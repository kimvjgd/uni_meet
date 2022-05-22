import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/controller/news_controller.dart';
import 'package:uni_meet/app/data/model/comment_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/data/repository/comment_repository.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/data/utils/timeago_util.dart';
import 'package:uni_meet/app/ui/widgets/input_bar.dart';
import 'package:uni_meet/app/ui/widgets/report_dialog.dart';
import '../../../../../controller/notification_controller.dart';
import '../../../../../data/model/firestore_keys.dart';
import '../../../../../data/repository/news_repository.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import '../../widgets/profile_widget.dart';
import '../widget/comment_item.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel post;

  PostDetailScreen({required this.post, Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController _commentController = TextEditingController();
  TextEditingController reportOffenderController = TextEditingController();
  TextEditingController reportContentController = TextEditingController();
  var _firstPress = true;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Logger().d(widget.post.hostNick!);
                              return ReportDialog(
                                reportOffenderController:
                                    reportOffenderController,
                                reportContentController:
                                    reportContentController,
                                reporter:
                                    AuthController.to.user.value.nickname!,
                                offender: widget.post.hostNick!,
                                content: reportContentController.text,
                              );
                            });
                      },
                    )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: _size.height,
              width: _size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _postContent(
                          TimeAgo.timeCustomFormat(widget.post.createdDate!))),
                  _commentContent(),
                ],
              ),
            ),
          ),
          bottomSheet: widget.post.host != AuthController.to.user.value.uid
              ? InputBar(
                  hintText: '댓글을 남겨주세요..',
                  textEditingController: _commentController,
                  onPress: () {
                    if (_commentController.text.trim() != '') {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                                title: '새 댓글 작성',
                                message: "댓글을 작성하시겠습니까?",
                                okCallback: () async {
                                  if (_firstPress) {
                                    _firstPress = false;
                                    await commentRepository
                                        .createNewComment(widget.post.postKey, {
                                      KEY_COMMENT_HOSTKEY:
                                          AuthController.to.user.value.uid,
                                      KEY_COMMENT_HOSTPUSHTOKEN:
                                          AuthController.to.user.value.token,
                                      KEY_COMMENT_HOSTINFO:
                                          '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}_${AuthController.to.user.value.localImage}_${AuthController.to.user.value.mbti}_${AuthController.to.user.value.gender}',
                                      KEY_COMMENT_CONTENT:
                                          _commentController.text,
                                      KEY_COMMENT_COMMENTTIME: DateTime.now()
                                    });

                                    // 푸시 알림
                                    print("게시글 작성자 토큰" +
                                        widget.post.hostpushToken.toString());
                                    await Get.put(NotificationController())
                                        .SendNewCommentNotification(
                                            Title: widget.post.title.toString(),
                                            receiver_token: widget
                                                .post.hostpushToken
                                                .toString());
                                    NewsController.to.newcomment(widget.post);
                                    //NewsRepository().createCommentNews(widget.post);
                                    Get.back();
                                    _commentController.clear();
                                    _firstPress = true;
                                  }
                                },
                                cancelCallback: Get.back,
                              ));
                    }
                  },
                )
              : SizedBox.shrink()),
    );
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
        GestureDetector(
          onTap: () {
            Get.dialog(AlertDialog(
              title: SizedBox(),
              content: ProfileWidget(
                  university: widget.post.hostInfo!.split('_')[0],
                  grade: widget.post.hostInfo!.split('_')[1] + '학번',
                  mbti: widget.post.hostInfo!.split('_')[4],
                  gender: widget.post.hostInfo!.split('_')[5],
                  nickname: widget.post.hostInfo!.split('_')[2],
                  localImage: widget.post.hostInfo!.split('_')[3]),
            ));
          },
          child: Row(
            children: [
              Text(
                widget.post.hostNick!+" ∙ "+widget.post.hostUni!+widget.post.hostGrade!+'학번',
                style: TextStyle(
                  color: app_systemGrey1,
                ),
              ),
            ],
          ),
        ),
        // Container(
        //     decoration: BoxDecoration(
        //         color: app_red.withOpacity(0.85),
        //         borderRadius: BorderRadius.circular(4.0)),
        //     child: Text(
        //       ' 외 ${widget.post.headCount! - 1}명 ',
        //       style: TextStyle(color: Colors.white),
        //     )),
        SizedBox(
          width: 2,
        ),

      ],
    );
  }

  Column _postContent(String cuteDong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            widget.post.title.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: _hostProfile(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                cuteDong, style: TextStyle(color: app_systemGrey1),
                // DateFormat.Md().add_Hm().format(widget.post.createdDate!),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
          child: Text(widget.post.content.toString(), maxLines: null),
        ),
      ],
    );
  }

  FutureBuilder _commentContent() {
    return FutureBuilder(
        future: commentRepository.loadCommentList(widget.post.postKey),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Center(
                      child: Text("작성된 댓글이 없습니다!"),
                    ),
                )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.separated(
                        reverse: false,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 60),
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            color: divider,
                          );
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (index == 0)
                            return Column(
                              children: [
                                Divider(
                                  thickness: 0.5,
                                  color: divider,
                                ),
                                CommentItem(
                                    comment: snapshot.data[index],
                                    post: widget.post)
                              ],
                            );
                          else
                            return CommentItem(
                                comment: snapshot.data[index], post: widget.post);
                        },
                      ),
                    ),
                  );
          } else if (snapshot.hasError) {
            return Column(children: [Container(child: Text(snapshot.error.toString())),],);
          } else
            return Container();
        });
  }
}
