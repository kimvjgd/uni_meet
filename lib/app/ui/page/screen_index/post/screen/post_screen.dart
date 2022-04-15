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
  // GetView<PostController> 추후에 바꿀 예정.... 분함 분함... <-제가 임의로 바꿨습니다 점검 부탁 -미녕
  Future _onRefresh() async {
    PostController.to.loadPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        actions: [IconButton(icon: Icon(Icons.more_vert_rounded),onPressed: (){},)],
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
}
