import 'package:get/get.dart';
import '../data/model/news_model.dart';

class NewsController extends GetxController{
  static NewsController get to => Get.find();
  RxList<NewsModel> newsList = <NewsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
}