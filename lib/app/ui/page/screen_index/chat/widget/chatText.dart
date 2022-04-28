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
    return isMine
        ? _buildMyMsg(context)
        : chatModel.writer!.startsWith('new')
            ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                      chatModel.message!,
                      style: TextStyle(fontSize: 15),
                    ),
                ),
              ),
            )
            : _buildOtherMsg(context);
  }

  Row _buildOtherMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 3,
        ),
        IconButton(
            icon: chatModel.writer!.split('_')[2] == '관리자'
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  )
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/momo${chatModel.writer!.split('_')[3]}.png'))),
                  ),
            onPressed: chatModel.writer!.split('_')[2] == '관리자'
                ? () {}
                : () {
                    Get.dialog(AlertDialog(
                      title: SizedBox(),
                      content: ProfileWidget(
                          university: chatModel.writer!.split('_')[0],
                          grade: chatModel.writer!.split('_')[1] + '학번',
                          mbti: chatModel.writer!.split('_')[4],
                          gender: chatModel.writer!.split('_')[5],
                          nickname: chatModel.writer!.split('_')[2],
                          localImage: chatModel.writer!.split('_')[3]),
                    ));
                  }),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                chatModel.writer!.split('_')[2],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    chatModel.message ?? '메세지 가려짐',
                    style: TextStyle(color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints:
                      BoxConstraints(minHeight: 40, maxWidth: size.width * 0.5),
                  decoration: BoxDecoration(
                    color: app_systemGrey5,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                _timeWidget(CrossAxisAlignment.start),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column _timeWidget(CrossAxisAlignment alignment) {
    print(chatModel.createdDate!.difference(DateTime.now()).inDays);
    return Column(
      crossAxisAlignment: alignment,
      children: [
        DateTime.now().difference(chatModel.createdDate!).inDays < 1
        // chatModel.createdDate!.difference(DateTime.now()).inDays < 1
            ? Text('')
            : Text(
                '${chatModel.createdDate!.month.toString()}/${chatModel.createdDate!.day.toString()}',style: TextStyle(fontSize: 12),),
        Text(
            '${chatModel.createdDate!.hour.toString()}:${chatModel.createdDate!.minute.toString()}'),
      ],
    );
  }

  Row _buildMyMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _timeWidget(CrossAxisAlignment.end),
        SizedBox(
          width: 6,
        ),
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
              BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
          decoration: BoxDecoration(
            color: app_green,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }
}
