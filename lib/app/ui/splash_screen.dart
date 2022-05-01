import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/root_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaml/yaml.dart';
import 'dart:io' show Platform;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  String? minAppVersion;
  String? latestAppVersion;
  String? User_Version;

  @override
  void initState() {
    User_Version = getMyVersion();
    getAppVersion();
    //  print("가공하면"+ User_Version);

    Timer(Duration(seconds: 2), () {
      int user_ver = Ver2Int(User_Version);

      if( user_ver < Ver2Int(minAppVersion)){
        showDialog(context: context,
            builder:(BuildContext context) {
              return AlertDialog(
                title: Center(child: Text("공지사항")),
                content: Text("중요한 변경 사항으로 업데이트 후 사용이 가능합니다.",textAlign: TextAlign.center,),
                actions: [
                  Center(
                    child: TextButton(
                        onPressed: () async{
                          //앱 스토어 링크?
                          if (Platform.isAndroid) {
                            final url = "https://play.google.com/store/apps/details?id=com.dongpakka.uni_meet";
                            if(await canLaunch(url)){
                              await launch(
                                url,forceWebView:true,
                                enableJavaScript:true,
                              );
                            }
                          }
                          else if (Platform.isIOS) {
                            // iOS-specific code
                            final url = "https://apps.apple.com/kr/app/momodu/id1620375953";
                            if(await canLaunch(url)){
                              await launch(
                                url,forceWebView:true,
                                enableJavaScript:true,
                              );
                            }
                          }
                        },
                        child: Text("업데이트하기",)
                    ),
                  ),
                ],
              );
            });
      }
      else if( user_ver < Ver2Int(latestAppVersion)){
        showDialog(context: context,
            builder:(BuildContext context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceAround,
                title: Center(child: Text("공지사항")),
                content: Text("최신 버전이 출시되었습니다!",textAlign: TextAlign.center,),
                actions: [
                  TextButton(
                      onPressed: () async{
                        //앱 스토어 링크?
                        if (Platform.isAndroid) {
                          final url = "https://play.google.com/store/apps/details?id=com.dongpakka.uni_meet";
                          if(await canLaunch(url)){
                            await launch(
                              url,forceWebView:true,
                              enableJavaScript:true,
                            );
                          }
                        }
                        else if (Platform.isIOS) {
                          // iOS-specific code
                        }
                      },
                      child: Text("업데이트하기",)
                  ),
                  TextButton(
                      onPressed: () async{
                        Get.offAll(RootPage());
                      },
                      child: Text("다음에",)
                  ),
                ],
              );
            });
      }
      else {Get.offAll(RootPage());}
    });
    super.initState();
  }

  String getMyVersion() {
    //기기에 설치된 버전 가져오기
    rootBundle.loadString("pubspec.yaml").then((value){
      var yaml = loadYaml(value);
      String version = yaml['version'];
      //  print("기기 내 앱 버전"+version);
      var data = version.split('+');
      User_Version = data[0];
  });
    return User_Version.toString();
  }

  Future<void> getAppVersion() async {
    FirebaseRemoteConfig remoteConfig = await FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();

    minAppVersion = remoteConfig.getString('min_version');
    latestAppVersion = remoteConfig.getString('latest_version');

   // print("최소 버전은"+minAppVersion!);
   // print("최신 버전은"+ latestAppVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.fill
              ))),
    );
  }
}

int Ver2Int(String? str){
  late int result;
  late String s='';
  if(str!=null){
    List<String> data = str.split(new RegExp(r"[^0-9]"));
    for(String element in data){
      if(element != " ") s += element;
    }
    result = int.parse(s);
  }

  return result;
}