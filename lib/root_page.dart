import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';

class RootPage extends GetView<AuthController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Container();
      }
    );
  }
}
