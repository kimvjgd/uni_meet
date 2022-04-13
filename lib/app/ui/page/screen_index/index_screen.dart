import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet/app/ui/page/screen_index/alarm/screen/alarm_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chat_list_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/message_popup.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/setting_screen.dart';

class IndexScreen extends GetView<BottomNavController> {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(() => Scaffold(
            body: Center(
              child: IndexedStack(
                index: controller.pageIndex.value,
                children: [
                  PostScreen(),
                  AlarmScreen(),
                  ChatListScreen(),
                  SettingScreen(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: (value) {
                controller.changeBottomNav(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.circle,
                    color: Colors.black,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.circle,
                      color: Colors.black,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.circle,
                      color: Colors.black,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.circle,
                      color: Colors.black,
                    ),
                    label: 'home'),
              ],
            ),
          )),
      onWillPop: willPopAction,
    );
  }

  Future<bool> willPopAction() async {
    showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
              title: '시스템',
              message: '종료하시겠습니까?',
              okCallback: () {
                exit(0);
              },
              cancelCallback: Get.back,
            ));
    return true;
  }
}
