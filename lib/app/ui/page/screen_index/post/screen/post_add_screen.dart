import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              Icon(Icons.arrow_back_ios),
              Text('홈'),
            ],
          ),
          title: Text('글쓰기 디자인 나중에'),
          actions: [Icon(Icons.wrap_text)],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('장소'),
                SizedBox(
                  width: 50,
                ),
                Text('예시 장소....')
              ],
            ),
            SizedBox(height: 30,),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: '제목을 입력해주세요.'),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: '내용을 입력해주세요.'),
            ),
            Spacer(),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: () async {
                    await PostRepository.createPost(title: _titleController.text,
                        content: _contentController.text,
                        place: '신촌',
                        headCount: 3,
                        createdDate: DateTime.now(),
                        host: AuthController.to.user.value.uid!,
                      hostpushToken: ""
                    );
                    Get.back();
                  }, child: Text('완료')),
            )
          ],
        ),
      ),
    );
  }
}
