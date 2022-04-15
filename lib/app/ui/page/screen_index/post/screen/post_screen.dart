import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/comment_controller.dart';
import 'package:uni_meet/app/controller/post_controller.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_add_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_detail_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/widget/post_item.dart';

class PostScreen extends StatefulWidget{
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Future _onRefresh() async {
    PostController.to.loadPostList();
  }

  @override
  Widget build(BuildContext context) {
    //PostController.to.loadPostList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
      ),
      body:
      RefreshIndicator(
        onRefresh:  _onRefresh,
        child: Obx(() =>ListView.separated(
          padding: EdgeInsets.all(16),
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: PostController.to.postList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: PostItem(post: PostController.to.postList[index]),
              onTap: () {
                Get.to(
                    PostItem(
                  post: PostController.to.postList[index],
                ));
              },
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(PostAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
