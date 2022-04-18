import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatelessWidget {
  var data;
  NoticeDetailScreen({required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("공지사항",style: TextStyle(color:Colors.grey[800]),),
      ),
      body: Center(
        child: Text(data.title),
      ),
    );
  }
}
