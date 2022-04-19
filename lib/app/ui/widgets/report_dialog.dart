import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/data/repository/report_repository.dart';

class ReportDialog extends StatelessWidget {
  TextEditingController reportOffenderController = TextEditingController();
  TextEditingController reportContentController = TextEditingController();
  String reporter;
  String offender;
  String content;

  ReportDialog({
    required this.reportOffenderController,
    required this.reportContentController,
    required this.reporter,
    required this.offender,
    required this.content,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    reportOffenderController.text = offender;

    return AlertDialog(
      content: Container(
          height: Get.height * 0.5,
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
                      reporter: reporter,
                        content: content,
                        offender: offender
                    );

                    /// TODO 1
                    // Form으로 내용이 비어있을때는 막아줘야하는데... 나중에   위의 문의하기도
                    Get.back();
                  },
                  child: Text("제출하기"))
            ],
          )),
    );
  }
}
