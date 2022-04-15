import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/model/chatroom_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';

class ChatController extends GetxController {
  ChatController(this.chatroomKey);

  static ChatController get to => Get.find();

  Rx<ChatroomModel> chat_chatroomModel = ChatroomModel(
          allUser: [],
          createDate: DateTime.now(),
          chatroomId: '',
          postKey: '',
          postTitle: '',
          lastMessage: '',
          place: '',
          lastMessageTime: DateTime.now(),
          headCount: 1)
      .obs;
  RxList<ChatModel> chat_chatList = <ChatModel>[].obs;
  final String chatroomKey;
  RxString chat_chatroomKey = ''.obs;

  void getxConstructor() {
    chat_chatroomKey.value = chatroomKey;
  }

  void addNewChat(ChatModel chatModel) {
    chat_chatList.insert(0, chatModel);
    ChatRepository().createNewChat(chat_chatroomKey.value, chatModel);

  }


  @override
  void onInit() {
    super.onInit();
    getxConstructor();
    ChatRepository()
        .connectChatroom(chat_chatroomKey.value)
        .listen((chatroomModel) {
      chat_chatroomModel(chatroomModel);

      if (chat_chatList.isEmpty) {
        ChatRepository().getChatList(chat_chatroomKey.value).then((chatList) {
          chat_chatList.addAll(chatList);
        });
      } else {
        if (chat_chatList[0].reference == null){
          chat_chatList.removeAt(0);
        }
        ChatRepository()
            .getLatestChatList(
                chat_chatroomKey.value, chat_chatList[0].reference!)
            .then((latestChats) {

          chat_chatList.insertAll(0, latestChats);
          update();
        });
      }
    });
  }
}
