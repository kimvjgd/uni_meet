import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/controller/post_controller.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_add_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/widget/post_item.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  // GetView<PostController> 추후에 바꿀 예정.... 분함 분함...

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future _onRefresh() async {
    PostController.to.loadPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_color,
        actions: [IconButton(onPressed: () async {
          await Get.to(PostAddScreen(),);
          setState(() {});
        }, icon: Icon(Icons.add,color: Colors.black,))],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: FutureBuilder<void>(
          future: _onRefresh(),
          builder: (context, snapshot) {
            return _postList();
          }
        ),
      ),
    );
  }

  Widget _postList() {
    return Obx(() => ListView(
          children: List.generate(
              PostController.to.postList.length,
              (index) => PostItem(post: PostController.to.postList[index])).toList(),
        ));
  }
}
