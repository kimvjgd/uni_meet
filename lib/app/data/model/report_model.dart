// 여기가 신고 모델임

import 'package:uni_meet/app/data/model/firestore_keys.dart';

class ReportModel {
  String? content;
  DateTime? createdDate;
  String? reporter; //신고를 한사람
  String? offender; //신고를 당한 사람

  ReportModel(
      {required this.content,
      required this.createdDate,
      required this.reporter,
      required this.offender});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      content: json[KEY_REPORT_CONTENT] == null ? '' : json[KEY_REPORT_CONTENT] as String,
      reporter: json[KEY_REPORT_REPORTER] == null ? '' : json[KEY_REPORT_REPORTER] as String,
      offender: json[KEY_REPORT_OFFENDER] == null ? '' : json[KEY_REPORT_OFFENDER] as String,
      createdDate: json[KEY_REPORT_CREATEDDATE] == null ? DateTime.now() : json[KEY_REPORT_CREATEDDATE].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_REPORT_CONTENT: content,
      KEY_REPORT_CREATEDDATE: createdDate,
      KEY_REPORT_REPORTER: reporter,
      KEY_REPORT_OFFENDER: offender,
    };
  }
}
