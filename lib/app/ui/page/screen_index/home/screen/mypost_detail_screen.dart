import 'package:flutter/material.dart';

class MyPostDetailScreen extends StatelessWidget {
  var data;
  MyPostDetailScreen({required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data.title),
      ),
    );
  }
}
