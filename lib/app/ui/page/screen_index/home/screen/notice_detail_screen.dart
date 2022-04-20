import 'package:flutter/material.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';

import '../../../../../data/utils/timeago_util.dart';
import '../../../../components/app_color.dart';

class NoticeDetailScreen extends StatelessWidget {
  NoticeModel notice;
  NoticeDetailScreen({required this.notice,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("공지사항",style: TextStyle(color:Colors.grey[800]),),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _Content(TimeAgo.timeCustomFormat(notice.createdDate!))),
          ],
        ),
      ),
    );
  }

  Column _Content(String cuteDong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20,0,10),
          child: Text(
            notice.title.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 60,
                child: Image.asset("assets/images/logo.png")
            ),
            Text("  모모두 팀  "),
            Text(cuteDong,style: TextStyle(color: app_systemGrey1),
              // DateFormat.Md().add_Hm().format(widget.post.createdDate!),
            ),
          ],
        ),
        Divider(
          thickness: 0.5,
          color: divider,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20,0,5),
          child: Text(notice.description.toString(), maxLines: null),
        ),
      ],
    );
  }
}
