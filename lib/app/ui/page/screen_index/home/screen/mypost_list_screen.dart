import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_detail_screen.dart';

class MyPostListScreen extends StatelessWidget {
  const MyPostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,),
      body: FutureBuilder<List<PostModel>>(
          future: PostRepository().getAllPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(MyPostDetailScreen(
                        data: snapshot.data![index],
                      ));
                    },
                    child: ListTile(
                      title: Text(
                        snapshot.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              itemCount: snapshot.data!.length,
            );
          }
      ),
    );
  }
}
