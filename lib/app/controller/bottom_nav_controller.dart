import 'package:get/get.dart';

enum PageName{HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changeBottomNav(int value) {
    var page = PageName.values[value];
    switch(page) {

      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.UPLOAD:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value);
        break;
    };
  }

  void _changePage(int value) {
    pageIndex(value);
  }

}