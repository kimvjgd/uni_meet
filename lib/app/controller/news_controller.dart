import 'package:get/get.dart';
import 'package:uni_meet/app/data/repository/news_repository.dart';
import '../data/model/news_model.dart';
import '../data/model/post_model.dart';

class NewsController extends GetxController{
  static NewsController get to => Get.find();
  RxList<NewsModel> newsList = <NewsModel>[].obs;
  //RxInt unread= 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void newcomment(PostModel post) async{
    NewsRepository.createCommentNews(post);


  }
  void newchat(String post_title,String receiverUID,String address) async{
    NewsRepository.createChatOpenNews(post_title, receiverUID, address);

  }

  Future<List<NewsModel>> alllnews() async {

    return NewsRepository.getAllNews();

  }

  void deletenews() async {

    NewsRepository.deleteALLNEWS();

  }


}