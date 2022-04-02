import 'package:flutter/material.dart';

class MajorTextFormField extends StatelessWidget {
  final String category;
  final TextEditingController majorController;
  const MajorTextFormField({
    required this.category,
    required this.majorController,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: TextFormField(
                  controller: majorController,
                  validator: (major) {
                    if (major!.isNotEmpty && major.length > 2) {
                      return null;
                    } else {
                      if (major.isEmpty) {
                        return '학과명을 입력해주세요.';
                      }
                      return '학과명을 정확히 기재해주세요.';
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
