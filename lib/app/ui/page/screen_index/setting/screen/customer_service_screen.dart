import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/personal_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/service_term_screen.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import 'alarm_screen.dart';
import 'open_source_screen.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> title = <String>['문의하기','신고하기','회원탈퇴',];

    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("고객센터",style: TextStyle(color:Colors.grey[800]),),
      ),
      body:Column(
        children: [
          Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1,color: app_systemGrey4);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(title[index]),
                    onTap: (){
                      if(index==0) showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                            title: '시스템',
                            message: '종료하시겠습니까?',
                            okCallback: () {

                            },
                            cancelCallback: Get.back,
                          ));
                      else if(index == 1) showDialog(
                          context: Get.context!,
                          builder: (context) => MessagePopup(
                            title: '시스템',
                            message: '종료하시겠습니까?',
                            okCallback: () {
                            },
                            cancelCallback: Get.back,
                          ));
                      else if(index == 2)
                        showDialog(
                            context: Get.context!,
                            builder: (context) => MessagePopup(
                              title: '시스템',
                              message: '종료하시겠습니까?',
                              okCallback: () {
                              },
                              cancelCallback: Get.back,
                            ));
                      else showDialog(
                            context: Get.context!,
                            builder: (context) => MessagePopup(
                              title: '시스템',
                              message: '종료하시겠습니까?',
                              okCallback: () {
                              },
                              cancelCallback: Get.back,
                            ));

                    },
                  );
                },
              )
          ),
        ],
      ),
    );
  }
}
