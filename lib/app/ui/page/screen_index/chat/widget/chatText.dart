import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/widgets/profile_widget.dart';

const roundedCorner = Radius.circular(20);

class ChatText extends StatelessWidget {
  final Size size;
  final bool isMine;
  final ChatModel chatModel;

  const ChatText({
    Key? key,
    required this.size,
    required this.isMine,
    required this.chatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMine ? _buildMyMsg(context) : _buildOtherMsg(context);
  }

  Row _buildOtherMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            icon: chatModel.writer!.split('_')[2] == '관리자'
                ? Container(decoration: BoxDecoration( image:DecorationImage(image:AssetImage('assets/images/logo.png'))),)
          : Container(decoration: BoxDecoration(image:DecorationImage(image:AssetImage('assets/images/momo${chatModel.writer!.split('_')[3]}.png')) ),),
    onPressed: chatModel.writer!.split('_')[2] == '관리자'
              ? () {}
              : () {
            Get.dialog(AlertDialog(
              title: SizedBox(),
              content: ProfileWidget(
                  university: chatModel.writer!.split('_')[0],
                  grade: chatModel.writer!.split('_')[1]+'학번',
                  mbti: chatModel.writer!.split('_')[4],
                  nickname: chatModel.writer!.split('_')[2],
                  localImage: chatModel.writer!.split('_')[3]),
            ));
          }
        ),
        SizedBox(
          width: 6,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chatModel.writer!.split('_')[2]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    chatModel.message ?? '메세지 가려짐',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints:
                  BoxConstraints(minHeight: 40, maxWidth: size.width * 0.5),
                  decoration: BoxDecoration(
                    color: app_deepyellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: roundedCorner,
                        bottomRight: roundedCorner,
                        bottomLeft: roundedCorner),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text('오전 10:25'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row _buildMyMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('오전 10:25'),
        SizedBox(
          width: 6,
        ),
        Container(
          child: Text(
            chatModel.message ?? '메세지 가려짐',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: app_systemGrey1),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints:
          BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
          decoration: BoxDecoration(
            color:app_lightyellow,
            borderRadius: BorderRadius.only(
                topLeft: roundedCorner,
                topRight: Radius.circular(2),
                bottomRight: roundedCorner,
                bottomLeft: roundedCorner),
          ),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }
}