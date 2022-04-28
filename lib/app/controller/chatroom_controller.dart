import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';

class ChatroomController extends GetxController {
  static ChatroomController get to => Get.find();

  RxList<ChatroomModel> chatroomList = <ChatroomModel>[].obs;
  // Rx<Chatroom> chatroom = Chatroom(allUser: [], createDate: DateTime.now(), postKey: '', headCount: 0).obs;

  void onInit() {
    getChatroomList();
    super.onInit();
  }

  void getChatroomList() async {
    if (chatroomList.isNotEmpty) chatroomList.clear();
    var loadChatroomList = await ChatRepository.loadChatroomList(
        AuthController.to.user.value.uid.toString()+'밍'+AuthController.to.user.value.token.toString());
    chatroomList.addAll(loadChatroomList);
    // return chatroomList;
  }

  // Future<String> getPostTitle(String postKey) async {
  //   // DocumentReference postRef = FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
  //   var postData = await FirebaseFirestore.instance
  //       .collection(COLLECTION_POSTS)
  //       .where(KEY_POST_POSYKEY, isEqualTo: postKey)
  //       .get();
  //   // Chatroom chatroom = Chatroom.fromJson(postData.docs.first.data());
  //   Post post = Post.fromJson(postKey, postData.docs.first.data());
  //   return post.title!;
  // }
}
