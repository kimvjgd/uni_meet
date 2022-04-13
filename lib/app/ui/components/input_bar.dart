import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Icon icon;
  final VoidCallback onPress;
  const InputBar({required this.textEditingController, required this.icon, required this.onPress, required this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ),
        IconButton(
            onPressed: onPress,
            icon:  icon),
      ],
    );
  }
}
