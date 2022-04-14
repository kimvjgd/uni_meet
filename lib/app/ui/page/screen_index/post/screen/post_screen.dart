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

class PostScreen extends GetView<PostController>{
  const PostScreen({Key? key}) : super(key: key);
  // GetView<PostController> 추후에 바꿀 예정.... 분함 분함... <-제가 임의로 바꿨습니다 점검 부탁 -미녕

  Future _onRefresh() async {
    controller.loadPostList();
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: controller.postList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: PostItem(post: controller.postList[index]),
              onTap: () {
                Get.to(
                    PostItem(
                  post: controller.postList[index],
                ));
              },
            );
          },
        )),
      ),
      // RefreshIndicator(
      //   onRefresh: _onRefresh,
      //   child: FutureBuilder<void>(
      //     future: _onRefresh(),
      //     builder: (context, snapshot) {
      //       return _postList();
      //     }
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(PostAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Widget _postList() {
  //   return Obx(() => ListView(
  //         children: List.generate(
  //             PostController.to.postList.length,
  //             (index) => PostItem(post: PostController.to.postList[index])).toList(),
  //       ));
  // }
}
