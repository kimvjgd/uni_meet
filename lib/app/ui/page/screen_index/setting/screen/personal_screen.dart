import 'package:flutter/material.dart';
class PersonalScreen extends StatelessWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("개인정보 이용방침",style: TextStyle(color:Colors.grey[800]),),
        leading: BackButton(color: Colors.grey[800],),
      ),
      body: Container(),
    );
  }
}
