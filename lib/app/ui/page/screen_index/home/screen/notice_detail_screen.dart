import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatelessWidget {
  var data;
  NoticeDetailScreen({required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data.title),
      ),
    );
  }
}
