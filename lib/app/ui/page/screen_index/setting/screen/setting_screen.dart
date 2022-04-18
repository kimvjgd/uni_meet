import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/alarm_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/customer_service_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/open_source_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/personal_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/service_term_screen.dart';
import 'package:uni_meet/root_page.dart';

import '../../../../components/app_color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final List<String> _title = <String>['알림 설정','고객센터','서비스 이용약관','개인정보 이용방침','오픈소스 라이센스',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 2,
        title: Text("설정",style: TextStyle(color:Colors.grey[800]),),
      ),
      body: Column(
        children: [
          _profile(),
          Divider(thickness: 1,color: app_systemGrey4),
          Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1,color: app_systemGrey4);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(_title[index]),
                    onTap: (){
                        if(index==0) Get.to(AlarmSettingScreen());
                        else if(index == 1) Get.to(CustomerServiceScreen());
                        else if(index == 2) Get.to(ServiceTermScreen());
                        else if(index == 3) Get.to(PersonalScreen());
                        else Get.to(OpneSourceScreen());
                    },
                  );
                },
              )
          ),
          TextButton(onPressed:signOut, child: Text("로그아웃"))
        ],
      ),
    );
  }


  Container _profile(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/momo' +
                    AuthController.to.user.value.localImage.toString() +
                    '.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AuthController.to.user.value.nickname.toString() + "님",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    AuthController.to.user.value.university.toString() +
                        " " +
                        AuthController.to.user.value.grade.toString() +
                        "학번 | " +
                        AuthController.to.user.value.major.toString(),
                    style: TextStyle(color: app_systemGrey1),
                  ),
                  Text(
                    AuthController.to.user.value.mbti.toString(),
                    style: TextStyle(color: app_systemGrey1),
                  ),
                  AuthController.to.user.value.auth!
                      ? Text("학생 인증 완료")
                      : Row(
                    children: [
                      Text(
                        "학생 인증 미완료  ",
                        style: TextStyle(color: app_systemGrey1),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (BuildContext child_context) {
                                  return AlertDialog(
                                    content: Text(
                                        "에브리타임 캡쳐 스크린을 선택 후, 전송하기를 눌러주세요.\n 24시간 이내로 확인 도와드릴게요!"),
                                    actions: [
                                      Center(
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                    "파일 찾아보기")),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child:
                                                Text("전송하기")),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "인증에 실패하셨나요?",
                            style: TextStyle(
                              color: app_red.withOpacity(0.8),
                            ),
                          )),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SettingsSection _aboutApp() {
    return SettingsSection(
      title: Text(''),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          leading: Icon(CupertinoIcons.rectangle_stack_person_crop),
          title: Text('About us'),
          onPressed: (context) {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>@@@));
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SettingsTile.navigation(
          leading: Icon(CupertinoIcons.wrench),
          title: Text('고객센터'),
          onPressed: (context) {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>@@@));
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SettingsTile.navigation(
          leading: Icon(Icons.account_balance_outlined),
          title: Text('서비스 이용약관'),
          onPressed: (context) {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>@@@));
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SettingsTile.navigation(
          leading: Icon(Icons.exit_to_app),
          title: Text('개인정보 이용방침'),
          onPressed: (context) async {
            AuthController.to.signOut();
            await auth.signOut();
            Get.to(()=>RootPage());
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SettingsTile.navigation(
          title: Text('오픈소스 라이센스'),
          onPressed: (context) async {
            AuthController.to.signOut();
            await auth.signOut();
            Get.to(()=>RootPage());
          },
        ),
        SettingsTile.navigation(
          title: Text('로그아웃'),
          onPressed: (context) async {
            AuthController.to.signOut();
            await auth.signOut();
            Get.to(()=>RootPage());
          },
        )
      ],
    );
  }

  Future<void> signOut() async {
    AuthController.to.signOut();
    await auth.signOut();
    Get.to(()=>RootPage());
  }
}