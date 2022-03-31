import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';

class AgeBottomSheet extends StatefulWidget {
  final int age;

  const AgeBottomSheet({required this.age, Key? key}) : super(key: key);

  @override
  State<AgeBottomSheet> createState() => _AgeBottomSheetState();
}

class _AgeBottomSheetState extends State<AgeBottomSheet> {
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    scrollController = FixedExtentScrollController(
        initialItem: Get.find<AuthController>().user.value.age != null
            ? Get.find<AuthController>().user.value.age! - 20
            : 0);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: scrollController,
      itemExtent: 30,
      onSelectedItemChanged: (int value) {
        Get.find<AuthController>().changeAge(20 + value);
      },
      children:
          List.generate(10, (index) => Text((index + 20).toString())).toList(),
    );
  }
}
