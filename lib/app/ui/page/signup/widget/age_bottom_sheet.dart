import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';

class AgeBottomSheet extends GetView<AuthController> {
  final int age;
  const AgeBottomSheet({
    required this.age,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return CupertinoPicker(

        itemExtent: 30,
        onSelectedItemChanged: (int value) {
          int temp_age = 20+value;
          controller.changeAge(temp_age);
          logger.d(controller.user.value.age.toString());
        },
        children: [
          Text('20'),
          Text('21'),
          Text('22'),
          Text('23'),
          Text('24'),
          Text('25'),
          Text('26'),
          Text('27'),
          Text('28'),
          Text('29'),
        ]);
  }
}
