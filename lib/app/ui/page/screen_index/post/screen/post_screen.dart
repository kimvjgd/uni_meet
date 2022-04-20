import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("게시판",style: TextStyle(color:Colors.grey[800]),),
      ),
      body:
      GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh:  _onRefresh,
          child: Obx(() =>ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10),
            separatorBuilder: (context, index) {
              return Divider(thickness: 1,color: app_systemGrey4);
            },
            itemCount: PostController.to.postList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PostItem(post: PostController.to.postList[index]),
              );
            },

          )),
        ),
      ),
      floatingActionButton: AuthController.to.user.value.auth==true
      ? FloatingActionButton(
        heroTag: 'write',
        foregroundColor: app_deepyellow,
        backgroundColor: app_lightyellow,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: 3,
        onPressed: () {
          Get.to(PostAddScreen());
        },
        child: Icon(Icons.create_outlined)
      )
          :FloatingActionButton(
          heroTag: 'write',
          foregroundColor: Colors.white,
          backgroundColor: app_systemGrey3,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          elevation: 3,
          onPressed: () {
            Get.snackbar("알림", "학교 인증을 완료해주세요 !");
          },
          child: Icon(Icons.create_outlined)
      )
    );
  }
}
