import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/utils/timeago_util.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_detail_screen.dart';


class PostItem extends StatelessWidget {
  final PostModel post;
  const PostItem({
    required this.post,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeAgo? _timeAgo;
    return GestureDetector(
      onTap: (){
         InitBinding.commentBinding();
         Get.to(()=>PostDetailScreen(post: post));
       },
      child: InkWell(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2,),
                    Text(
                      post.title?? '빈 제목',
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 9,),
                    // Text(
                    //   post.content?? '내용 없음',
                    //   style:Theme.of(context).textTheme.bodySmall,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,),
                    // SizedBox(height: 7,),
                    Row(children: [
                      Text(
                        post.hostNick!+' '+post.hostUni!+' ' + post.hostGrade!+'학번 ',
                      style: TextStyle(color: app_systemGrey1),
                    ),
                      // Container(
                      //     decoration: BoxDecoration(
                      //         color: app_red.withOpacity(0.85),
                      //         borderRadius: BorderRadius.circular(4.0)),
                      //     child: Text(' 외 ${post.headC ount! - 1}명 ',style: TextStyle(color: Colors.white),)),
                      SizedBox(width: 2,),
                      //Text("#${post.place} ",style: TextStyle(color: app_green),),
                      Text(
                          TimeAgo.timeCustomFormat(post.createdDate!)
                      )
                    ],)

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}