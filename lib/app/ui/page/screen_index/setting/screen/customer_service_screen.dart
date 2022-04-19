import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/repository/contact_repository.dart';
import 'package:uni_meet/app/data/repository/report_repository.dart';
import 'package:uni_meet/app/data/repository/user_repository.dart';
import 'package:uni_meet/app/ui/page/account/edit_number.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/service_term_screen.dart';
import 'package:uni_meet/app/ui/start.dart';
import 'package:uni_meet/app/ui/widgets/report_dialog.dart';
import 'package:uni_meet/root_page.dart';
import '../../../../components/app_color.dart';
import '../../message_popup.dart';
import 'alarm_screen.dart';
import 'open_source_screen.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  /// TODO2 컨트롤러를 따로 빼줘야 alert창이 꺼지면 같이 꺼질것 같은데 이것도 기능구현하고 나중에 고칠 예정
  TextEditingController reportOffenderController = TextEditingController();
  TextEditingController reportContentController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController contactContentController = TextEditingController();

  @override
  void dispose() {
    reportOffenderController.dispose();
    reportContentController.dispose();
    contactContentController.dispose();
    contactEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            "고객센터",
            style: TextStyle(color: Colors.grey[800]),
          ),
          leading: BackButton(
            color: Colors.grey[800],
          ),
        ),
        body: ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                title: Text("문의하기"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDialog(
                            reportOffenderController: reportOffenderController,
                            reportContentController: reportContentController,
                            reporter: AuthController.to.user.value.nickname!,
                            offender: reportOffenderController.text,
                            content: reportContentController.text);
                      });
                },
              ),
              Divider(
                thickness: 1,
                color: app_systemGrey4,
              ),
              ListTile(
                title: Text("신고하기"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                              height: _size.height * 0.5,
                              child: Column(
                                children: [
                                  Expanded(flex: 1, child: Text("신고하기")),
                                  Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: reportOffenderController,
                                        decoration: InputDecoration(
                                            hintText: '신고 대상의 닉네임을 입력해주세요'),
                                      )),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      maxLines: 10,
                                      controller: reportContentController,
                                      decoration: InputDecoration(
                                        hintText:
                                        '신고 내용을 작성해주세요!\n이미지 첨부 시, team.momodu@gmail.com\n으로 첨부를 부탁드립니다!',
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await ReportRepository.createdReport(
                                            reporter: AuthController
                                                .to.user.value.nickname!,
                                            content: reportContentController
                                                .text,
                                            offender:
                                            reportOffenderController.text);

                                        /// TODO 1
                                        // Form으로 내용이 비어있을때는 막아줘야하는데... 나중에   위의 문의하기도
                                        Get.back();
                                      },
                                      child: Text("제출하기"))
                                ],
                              )),
                        );
                      });
                },
              ),
              Divider(
                thickness: 1,
                color: app_systemGrey4,
              ),
              ListTile(
                title: Text("회원탈퇴"),
                onTap: () async {
                  showDialog(
                      context: Get.context!,
                      builder: (context) =>
                          MessagePopup(
                            title: '회원탈퇴',
                            message: '정말 탈퇴하시겠습니까?',
                            okCallback: () {
                              // 탈퇴기능
                              // 파이어 베이스 auth에서 탈퇴

                              // collection에서 제거
                              UserRepository.withdrawal(AuthController.to.user
                                  .value.uid!);
                              Get.offAll(() => StartScreen());
                            },
                            cancelCallback: Get.back,
                          ));
                },
              ),
              Divider(
                thickness: 1,
                color: app_systemGrey4,
              ),
            ]).toList()));
  }
}
