import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/notice_model.dart';
import 'package:uni_meet/app/data/model/report_model.dart';

class ReportRepository {
  static final ReportRepository _reportRepository =
      ReportRepository._internal();

  factory ReportRepository() => _reportRepository;

  ReportRepository._internal();

  static Future<void> createdReport(
      {required String reporter,
      required String content,
      required String offender}) async {
    DocumentReference reportRef =
        FirebaseFirestore.instance.collection(COLLECTION_REPORTS).doc();
    ReportModel report = ReportModel(
        content: content,
        createdDate: DateTime.now(),
        reporter: reporter,
        offender: offender);
    await reportRef.set(report.toMap());
  }
}
