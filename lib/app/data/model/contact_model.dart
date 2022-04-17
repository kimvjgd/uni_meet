import 'package:uni_meet/app/data/model/firestore_keys.dart';

class ContactModel {
  String? responseEmail;
  String? content;
  DateTime? createdDate;

  ContactModel(
      {required this.responseEmail,
      required this.content,
      required this.createdDate});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        responseEmail: json[KEY_CONTACT_RESPONSEEMAIL] == null
            ? ''
            : json[KEY_CONTACT_RESPONSEEMAIL] as String,
        content: json[KEY_CONTACT_CONTENT] == null
            ? ''
            : json[KEY_CONTACT_CONTENT] as String,
        createdDate: json[KEY_CONTACT_CREATEDDATE] == null
            ? DateTime.now()
            : json[KEY_CONTACT_CREATEDDATE].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_CONTACT_CONTENT: content,
      KEY_CONTACT_CREATEDDATE: createdDate,
      KEY_CONTACT_RESPONSEEMAIL: responseEmail,
    };
  }
}
