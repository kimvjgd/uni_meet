import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/mypost_detail_screen.dart';

import '../../../../components/app_color.dart';
import '../../post/screen/post_detail_screen.dart';

class MyPostListScreen extends StatelessWidget {
  const MyPostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("내가 쓴 글",style: TextStyle(color:Colors.grey[800]),),
      ),
      body: FutureBuilder<List<PostModel>>(
          future: PostRepository().getAllPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(color: divider,),
              itemBuilder: (context, index){
                //if(snapshot.data!.length > 1 && index == snapshot.data!.length) return SizedBox(width: 0,);
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(PostDetailScreen(
                          post: snapshot.data![index],
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
                    ),
                   // if(snapshot.data!.length == 1) Divider(color: divider,)
                  ],
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
      ),
    );
  }
}
