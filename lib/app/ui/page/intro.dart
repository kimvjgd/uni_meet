import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/root_page.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        backgroundImage: 'assets/images/intro1.png',
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
        backgroundImage: 'assets/images/intro2.png',
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
        backgroundImage: 'assets/images/intro3.png',
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
        widgetTitle: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:125),
            child: RichText(
              text:TextSpan(children: [
                TextSpan(text: "대학생을 위한",style: TextStyle(fontSize:22,color:Colors.black)),
                TextSpan(text: " 새로운 미팅", style: TextStyle(fontSize:22,color: Colors.green,))
              ]),
            ),
          ),
        ),
        centerWidget: Padding(
          padding: const EdgeInsets.only(top:250),
          child: BigButton(onPressed: (){Get.to(RootPage());}, btnText: '시작하기',),
        ),
        backgroundOpacity: 0.0,
        backgroundColor: Colors.white,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
  }

  void onDonePress() {
    _storeOnboardInfo();
    Get.to(RootPage());
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  Widget renderNextBtn() {
    return Text("다음",style: TextStyle(color: Colors.green),);
  }

  Widget renderSkipBtn() {
    return Text("SKIP",style: TextStyle(color: Colors.grey),);
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', 0);
    print(prefs.getInt('onBoard'));
  }


  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      onSkipPress:_storeOnboardInfo(),

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