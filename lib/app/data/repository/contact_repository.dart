import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/contact_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/report_model.dart';

class ContactRepository {
  static final ContactRepository _contactRepository =
  ContactRepository._internal();

  factory ContactRepository() => _contactRepository;

  ContactRepository._internal();

  static Future<void> createdContact(
      {required String responseEmail,
        required String content}) async {
    DocumentReference contactRef =
    FirebaseFirestore.instance.collection(COLLECTION_CONTACTS).doc();
    ContactModel contact = ContactModel(responseEmail: responseEmail, content: content, createdDate: DateTime.now());
    await contactRef.set(contact.toMap());
  }
}
