import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PersonalInfoScreen extends StatelessWidget {
    WebViewController? controller;

    String url = 'https://sites.google.com/view/momodu-pi-ap/%ED%99%88';

  @override
  Widget build(BuildContext context) {


    // ios
    // 개인정보처리동의서
    // https://sites.google.com/view/momodu-pi-ap/%ED%99%88

    // aos
    // 개인정보처리동의서
    // https://sites.google.com/view/momodu-pi-gg/%ED%99%88

    Future<void> init() async {
      if (controller == null) {}
      await controller!.loadUrl(url);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "개인정보처리 동의서",
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: BackButton(
          color: Colors.grey[800],
        ),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return WebView(
                  onWebViewCreated: (WebViewController controller) {
                    this.controller = controller;
                  },
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                );
              default:
                return Center(
                  child: Text('인터넷 연결을 해주세요.'),
                );
            }
          }),
    );
  }
}
