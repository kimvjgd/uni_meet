import 'package:flutter/material.dart';
class ServiceTermScreen extends StatelessWidget {
  const ServiceTermScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("서비스 이용약관",style: TextStyle(color:Colors.grey[800]),),
        leading: BackButton(color: Colors.grey[800],),
      ),
      body: Container(),
    );
  }
}
