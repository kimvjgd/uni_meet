import 'package:flutter/material.dart';
class OpneSourceScreen extends StatelessWidget {
  const OpneSourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("오픈소스 라이센스",style: TextStyle(color:Colors.grey[800]),),
        leading: BackButton(color: Colors.grey[800],),
      ),
      body: Container(),
    );
  }
}
