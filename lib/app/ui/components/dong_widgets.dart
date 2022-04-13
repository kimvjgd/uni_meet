import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/components/dong_constants.dart';

class BottomSheetBody extends StatelessWidget {
  BottomSheetBody({Key? key, required this.children}) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
