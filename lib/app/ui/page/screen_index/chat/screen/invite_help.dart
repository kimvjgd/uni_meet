import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/root_page.dart';
import 'package:get/get.dart';

class InviteHelp extends StatefulWidget {
  InviteHelp({Key? key}) : super(key: key);

  @override
  InviteHelpState createState() => new InviteHelpState();
}

// ------------------ Custom config ------------------
class InviteHelpState extends State<InviteHelp> {
  List<Slide> slides = [];
  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        backgroundImage: 'assets/images/invite_help_1.jpeg',
        backgroundColor: Colors.white,
        backgroundImageFit: BoxFit.contain,
        backgroundOpacity: 0.0,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      Slide(
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        backgroundImage: 'assets/images/invite_help_3.jpeg',
        backgroundImageFit: BoxFit.contain,
        backgroundOpacity: 0.0,
        backgroundColor: Colors.white,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      Slide(
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        backgroundImage: 'assets/images/invite_help_2.jpeg',
        backgroundImageFit: BoxFit.contain,
        backgroundOpacity: 0.0,
        backgroundColor: Colors.white,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
  }

  void onDonePress() {
    // _storeOnboardInfo();
    // Get.to(RootPage());
    Get.back();
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  Widget renderNextBtn() {
    return Text("??????",style: TextStyle(color: Colors.green),);
  }

  Widget renderSkipBtn() {
    return Text("SKIP",style: TextStyle(color: Colors.grey),);
  }

  // _storeOnboardInfo() async {
  //   print("Shared pref called");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('onBoard', 0);
  //   print(prefs.getInt('onBoard'));
  // }


  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      // onSkipPress:() => _storeOnboardInfo(),

      onDonePress: onDonePress,
      // Next button
      renderNextBtn: this.renderNextBtn(),
      onNextPress: this.onNextPress,

      // Dot indicator
      colorDot: app_systemGrey5,
      colorActiveDot: Colors.green,
      sizeDot: 10.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}