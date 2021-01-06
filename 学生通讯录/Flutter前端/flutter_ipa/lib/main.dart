import 'package:flutter/material.dart';
import 'package:flutter_ipa/about.dart';
import 'package:flutter_ipa/addIpa.dart';
import 'package:flutter_ipa/alterInfo.dart';
import 'package:flutter_ipa/bottom/message.dart';
import 'package:flutter_ipa/home.dart';
import 'package:flutter_ipa/login.dart';
import 'package:flutter_ipa/private_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigator =GlobalKey();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      routes: <String,WidgetBuilder>{
        '/addPage':(BuildContext context) => addIpa(),
        '/login':(BuildContext context) => login_page(),
        '/home':(BuildContext context) => home_page(),
        '/userData':(BuildContext context) => user_page(),
        '/alterInfo':(BuildContext context) => alterInfo(),
        '/message':(BuildContext context) => message(),
        '/about':(BuildContext context) => about()
      },
      debugShowCheckedModeBanner: false,
      title: '通讯录',
      home:login_page()
    );
  }
}
