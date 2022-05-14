import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/home_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/screen/chat_list_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/message_popup.dart';
import 'package:uni_meet/app/ui/page/screen_index/post/screen/post_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/setting/screen/setting_screen.dart';

import 'home/screen/home_screen.dart';

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
                  HomeScreen(),
                  PostScreen(),
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
                  icon: ImageIcon(AssetImage("assets/images/icons/home_icon.png")),
                  activeIcon: ImageIcon(AssetImage("assets/images/icons/home_icon.png"),color: Colors.green,),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon:  ImageIcon(AssetImage("assets/images/icons/post_icon.png")),
                    activeIcon: ImageIcon(AssetImage("assets/images/icons/post_icon.png",),color: Colors.green,),
                    label: 'list'),
                BottomNavigationBarItem(
                    icon:  ImageIcon(AssetImage("assets/images/icons/chat_icon.png")),
                    activeIcon: ImageIcon(AssetImage("assets/images/icons/chat_icon.png",),color: Colors.green,),
                    label: 'chat'),
                BottomNavigationBarItem(
                    icon:  ImageIcon(AssetImage("assets/images/icons/myroom_icon.png")),
                    activeIcon: ImageIcon(AssetImage("assets/images/icons/myroom_icon.png",),color: Colors.green,),
                    label: 'setting'),
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
              title: '모모두',
              message: '정말 종료하시겠습니까?',
              okCallback: () {
                exit(0);
              },
              cancelCallback: Get.back,
            ));
    return true;
  }
}
