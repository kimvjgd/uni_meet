import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/binding/init_bindings.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/data/model/app_user_model.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/model/chatter_model.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chatroom_screen.dart';

class ChatRepository {
  static final ChatRepository _chatRepository = ChatRepository._internal();

  factory ChatRepository() => _chatRepository;

  ChatRepository._internal();

  Future createNewChatroom(
      ChatroomModel chatroom, String postUserId, String commentUserId) async {
    DocumentReference<Map<String, dynamic>> chatroomReference =
        FirebaseFirestore.instance.collection(COLLECTION_CHATROOMS).doc();
    DocumentReference<Map<String, dynamic>> chatReference = FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc()
        .collection(COLLECTION_CHATS)
        .doc();
    DocumentReference<Map<String, dynamic>> postUserReference =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(postUserId);
    DocumentReference<Map<String, dynamic>> commentUserReference =
        FirebaseFirestore.instance
            .collection(COLLECTION_USERS)
            .doc(commentUserId);

    var chatRef = await chatroomReference.collection(COLLECTION_CHATS).doc();

    var chatData = chatRef.set(ChatModel(
            writer: '관리자_관리자_관리자',
            createdDate: DateTime.now(),
            message: '첫 메세지를 보내주세요.',
            reference: chatRef)
        .toMap());
    var postUserData = await postUserReference.get();
    var commentUserData = await commentUserReference.get();

    List<dynamic> postUserChatroomList =
        postUserData.data()![KEY_USER_CHATROOMLIST] ?? [];
    List<dynamic> commentUserChatroomList =
        commentUserData.data()![KEY_USER_CHATROOMLIST] ?? [];

    if (postUserChatroomList.contains(chatroomReference.id) ||
        commentUserChatroomList.contains(chatroomReference.id)) {
      Get.snackbar("알림", "이미 채팅방이 존재합니다.");
      return;
    }
    // if (!postUserChatroomList.contains(chatroomReference.id)) {
    // }
    // if (!commentUserChatroomList.contains(chatroomReference.id)) {
    // }
    postUserChatroomList.add(chatroomReference.id);
    commentUserChatroomList.add(chatroomReference.id);

    final DocumentSnapshot documentSnapshot = await chatroomReference.get();
    if (!documentSnapshot.exists) {
      chatroom.chatroomId = chatroomReference.id;
      chatroom.reference = chatroomReference;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(chatroomReference, chatroom.toMap());
        transaction.update(
            postUserReference, {KEY_USER_CHATROOMLIST: postUserChatroomList});
        transaction.update(commentUserReference,
            {KEY_USER_CHATROOMLIST: commentUserChatroomList});
      });
    } else {
      Get.snackbar("개발자에게 알림", "chatrooms 생성");
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////

  static Future<List<ChatroomModel>> loadChatroomList(String userKey) async {
    var documentReference =
        FirebaseFirestore.instance.collection(COLLECTION_CHATROOMS);
    var document = documentReference
        .where(KEY_CHATROOM_ALLUSER, arrayContains: userKey)
        .orderBy(KEY_CHATROOM_CREATEDDATE, descending: true);
    var data = await document.get();
    return data.docs
        .map<ChatroomModel>((e) => ChatroomModel.fromJson(e.data()))
        .toList();
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Future createNewChat(String chatroomKey, ChatModel chat) async {
    DocumentReference<Map<String, dynamic>> chatsReference = FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .doc();

    DocumentReference<Map<String, dynamic>> chatroomReference =
        FirebaseFirestore.instance
            .collection(COLLECTION_CHATROOMS)
            .doc(chatroomKey);

    // await chatsReference.set(chat.toMap());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      chat.reference = chatsReference;
      transaction.set(chatsReference, chat.toMap());
      transaction.update(chatroomReference, {
        KEY_CHATROOM_LASTMESSAGE: chat.message,
        KEY_CHATROOM_LASTMESSAGETIME: DateTime.now()
      });
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  /////////////////////////////////////////////////////////////////////////////////////

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromJson(snapshot.data()!);
    sink.add(chatroom);
  });

  /////////////////////////////////////////////////////////////////////////////////////

  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .orderBy(KEY_CHAT_CREATEDDATE, descending: true)
        .limit(15)
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      DocumentReference chatRef = docSnapshot.reference;
      ChatModel chat = ChatModel.fromJson(docSnapshot.data(), chatRef);
      chatList.add(chat);
    });
    return chatList;
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Future<List<ChatModel>> getLatestChatList(
      String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .orderBy(KEY_CHAT_CREATEDDATE, descending: true)
        .endBeforeDocument(
            await currentLatestChatRef.get()) // endAtDocumentㅇㅣㄴ가...?
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      DocumentReference chatRef = docSnapshot.reference;
      ChatModel chat = ChatModel.fromJson(docSnapshot.data(), chatRef);
      chatList.add(chat);
    });
    return chatList;
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Future<List<ChatModel>> getOlderChatList(
      String chatroomKey, DocumentReference oldestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .orderBy(KEY_CHAT_CREATEDDATE, descending: true)
        .startAfterDocument(await oldestChatRef.get())
        .limit(5)
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      DocumentReference chatRef = docSnapshot.reference;
      ChatModel chat = ChatModel.fromJson(docSnapshot.data(), chatRef);
      chatList.add(chat);
    });
    return chatList;
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Future<List<ChatroomModel>> getMyChatList(String myUid) async {
    List<ChatroomModel> chatrooms = [];
    QuerySnapshot<Map<String, dynamic>> list = await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .where(KEY_CHATROOM_ALLUSER, arrayContains: myUid)
        .orderBy(KEY_CHATROOM_LASTMESSAGETIME, descending: true)
        .get();

    list.docs.forEach((documentSnapshot) {
      chatrooms.add(ChatroomModel.fromJson(documentSnapshot.data()));
    });
    return chatrooms;
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Future<void> enterExistedChatroom(String chatroomKey) async {
    AppUserModel user = AuthController.to.user.value;
    var prev_data = await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .get();

    List<dynamic> data = await prev_data.get(KEY_CHATROOM_ALLUSER);
    Set<dynamic> semiResult = data.toSet();
    semiResult.add(user.uid);
    List<dynamic> result = semiResult.toList();

    List<dynamic> data_token = await prev_data.get(KEY_CHATROOM_ALLTOKEN);
    Set<dynamic> semiResult_token = data_token.toSet();
    semiResult_token.add(user.token);
    List<dynamic> result_token = semiResult_token.toList();

    String newAccount =
        'new_account_뀨${user.nickname}뀨_0_nope'; // nickname뒤는 뒤는 불필요한데 혹시 몰라 불안해서 넣음
    await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .add({
      KEY_CHAT_WRITER: newAccount,
      KEY_CHAT_MESSAGE: '${user.nickname}님 께서 입장하셨습니다.',
      KEY_CHAT_CREATEDDATE: DateTime.now()
    });
    await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .update({KEY_CHATROOM_ALLUSER: result});
    await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .update({KEY_CHATROOM_ALLTOKEN: result_token});

    Get.to(() => ChatroomScreen(chatroomKey: chatroomKey),
        binding: InitBinding.chatroomBinding(chatroomKey));
  }

  Future<void> exitChatroom(String chatroomKey) async {
    bool emptyChatroom = false;
    var chatroom_prev_data = await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .get();
    var user_prev_data = await FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(AuthController.to.user.value.uid)
        .get();
    List<dynamic> chatroom_data =
        await chatroom_prev_data.get(KEY_CHATROOM_ALLUSER);

    List<dynamic> chatroom_data_token =
        await chatroom_prev_data.get(KEY_CHATROOM_ALLTOKEN);

    List<dynamic> user_data = await user_prev_data.get(KEY_USER_CHATROOMLIST);

    chatroom_data.remove(AuthController.to.user.value.uid);
    chatroom_data_token.remove(AuthController.to.user.value.token);
    user_data.remove(chatroomKey);
    if (chatroom_data.isEmpty) {
      emptyChatroom = true;
    }

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      if (emptyChatroom) {
        transaction.delete(FirebaseFirestore.instance
            .collection(COLLECTION_CHATROOMS)
            .doc(chatroomKey));
        transaction.update(
            FirebaseFirestore.instance
                .collection(COLLECTION_USERS)
                .doc(AuthController.to.user.value.uid),
            {KEY_USER_CHATROOMLIST: user_data});
      } else {
        transaction.update(
            FirebaseFirestore.instance
                .collection(COLLECTION_CHATROOMS)
                .doc(chatroomKey),
            {KEY_CHATROOM_ALLUSER: chatroom_data});
        transaction.update(
            FirebaseFirestore.instance
                .collection(COLLECTION_CHATROOMS)
                .doc(chatroomKey),
            {KEY_CHATROOM_ALLTOKEN: chatroom_data_token});
        transaction.update(
            FirebaseFirestore.instance
                .collection(COLLECTION_USERS)
                .doc(AuthController.to.user.value.uid),
            {KEY_USER_CHATROOMLIST: user_data});
      }
    });
  }

  static Future<List<ChatterModel>> getChatterInfo(String chatroomKeys) async {
    List<ChatterModel> chatterModels = [];

    var userData = await FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKeys)
        .get();
    var intermediate = userData.data();
    var userUids = intermediate![KEY_CHATROOM_ALLUSER];

    // print(userUids);

    for (String uid in userUids) {
      var data = await FirebaseFirestore.instance
          .collection(COLLECTION_USERS)
          .doc(uid)
          .get();
      var tempData = data.data();

      chatterModels.add(ChatterModel(
          nickname: tempData![KEY_USER_NICKNAME],
          university: tempData[KEY_USER_UNIVERSITY],
          grade: tempData[KEY_USER_GRADE].toString(),
          mbti: tempData[KEY_USER_MBTI],
          gender: tempData[KEY_USER_GENDER],
          localImage: tempData[KEY_USER_LOCALIMAGE].toString()));
    }

    // for(int i=0; i<3; i++) {
    //   print(chatterModels[i].nickname);
    //   print(chatterModels[i].university);
    //   print(chatterModels[i].grade);
    //   print(chatterModels[i].mbti);
    //   print(chatterModels[i].gender);
    //   print(chatterModels[i].localImage);
    // }

    return chatterModels;
  }
}
