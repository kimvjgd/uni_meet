import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/app_color.dart';

enum Alarm_CHAT { ON, OFF }
enum Alarm_COMMENT { ON, OFF }
enum Alarm_NOTICE { ON, OFF }

class AlarmSettingScreen extends StatefulWidget {
  const AlarmSettingScreen({Key? key}) : super(key: key);

  @override
  State<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  bool chat_ON = true;
  bool comment_ON = true;
  bool notice_ON = true;
  Alarm_COMMENT _comment = Alarm_COMMENT.ON;
  Alarm_NOTICE _notice = Alarm_NOTICE.ON;

  final List<String> _title = <String>[
    '채팅방 개설 알림',
    '새 댓글 알림',
    '공지사항 알림',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: BackButton(
          color: Colors.grey[800],
        ),
        title: Text(
          "알림 설정",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: ListView(
        children:
        ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("채팅방 알림"),
                      Switch(
                          activeColor: app_red,
                          value: chat_ON,
                          onChanged: (value) {
                            setState(() {
                              chat_ON = value;
                            });
                          }),
                  ],
                  ),
                  onTap: (){},
                ),
                Divider(thickness: 1,color: app_systemGrey4,),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("댓글 알림"),
                    Switch(
                        activeColor: app_red,
                        value: comment_ON,
                        onChanged: (value) {
                          setState(() {
                            comment_ON = value;
                          });
                        })

                  ],),
                  onTap: (){},
                ),
                Divider(thickness: 1,color: app_systemGrey4,),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("공지사항 알림"),
                    Switch(
                        activeColor: app_red,
                        value: notice_ON,
                        onChanged: (value) {
                          setState(() {
                            notice_ON = value;
                          });
                        }),
                  ],),
                  onTap: (){},
                ),
                Divider(thickness: 1,color: app_systemGrey4,),
              ]
          ).toList()
        )
    );
  }
}
