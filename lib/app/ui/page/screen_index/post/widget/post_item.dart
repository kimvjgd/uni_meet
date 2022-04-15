import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/utils/timeago_util.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_detail_screen.dart';


class PostItem extends StatelessWidget {
  final PostModel post;
  const PostItem({
    required this.post,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeAgo? _timeAgo;
    return SizedBox(
      width: MediaQuery.of(context).size.width,

       child: GestureDetector(
         onTap: (){
           InitBinding.commentBinding();
           Get.to(()=>PostDetailScreen(post: post));
         },
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(post.headCount.toString()+"명/"+post.place.toString()
                      ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    SizedBox(height: 7,),
                    Text(
                      post.title?? '빈 제목',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7,),
                    Text(
                      post.content?? '내용 없음',
                      style:Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 7,),
                    Text(post.host.toString(),style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
              ),
            ],
          ),
        ),)
    );
  }
}