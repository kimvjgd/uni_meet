import 'package:flutter/material.dart';

import '../components/app_color.dart';

class InputBar extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback onPress;
  const InputBar({required this.textEditingController, required this.onPress, required this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none,),
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 3, 15),
                  hintText: hintText,
                hintStyle: TextStyle(color: app_systemGrey4),
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                suffixIcon: IconButton(
                  icon: ImageIcon(AssetImage("assets/images/icons/send_chat_icon.png")),
                  onPressed: onPress,)
    )
    ),
            ),
          ),
      ],
    );
  }
}
