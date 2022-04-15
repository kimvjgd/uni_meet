import 'package:get/get.dart';
import 'package:uni_meet/app/data/model/post_model.dart';
import 'package:uni_meet/app/data/repository/post_repository.dart';

class PostController extends GetxController{
  static PostController get to => Get.find();
  RxList<PostModel> postList = <PostModel>[].obs;

  @override
  void onInit() {
    loadPostList();
    super.onInit();
  }

  void loadPostList() async {
    if(postList.isNotEmpty) postList.clear();
    var myList = await PostRepository.loadPostList();
    postList.addAll(myList);
  }

}