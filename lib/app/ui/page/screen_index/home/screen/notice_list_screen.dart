import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/repository/notice_repository.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/notice_detail_screen.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({Key? key}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("공지사항",style: TextStyle(color:Colors.grey[800]),),
      ),
      body: FutureBuilder<List<NoticeModel>>(
        future: NoticeRepository().getAllNotices(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(color: divider,),
            itemBuilder: (context, index){
            //  if(snapshot.data!.length > 1 && index == snapshot.data!.length) return SizedBox(width: 0,);
              return Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(NoticeDetailScreen(
                      notice: snapshot.data![index],
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
                //if(snapshot.data!.length == 1) Divider(color: divider,)
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
