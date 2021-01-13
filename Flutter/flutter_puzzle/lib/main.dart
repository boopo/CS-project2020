import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/dialogs/dialog.dart';
import 'package:flutter_puzzle/routes/login_route.dart';

import 'routes/game_route.dart';
import 'routes/home_route.dart';
bool isLogin = false;
void main() async{
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintLayerBordersEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

  //强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //设置状态栏透明
  if(Platform.isAndroid){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigator =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拼图',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomeRoute(),
        "/game": (context) => GameRoute(),
        '/login':(context) => login_page(),
        '/dialog':(context) => dialog()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
