import 'package:flutter/material.dart';
import 'package:flutter_puzzle/database/data.dart';
import 'package:flutter_puzzle/r.dart';

import 'package:flutter_puzzle/main.dart';

import '../main.dart';


class login_page extends StatefulWidget{
  @override
  _login createState() => _login();
}
TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();
class _login extends State<login_page>{
  @override
  void initState() {
    isLogin = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(80),
              width: 300,
              height: 200,
              child:Image.asset('images/Flying.jpg'),
            ),
            loginTextField("请输入学号",getUsername,username,false),
            loginTextField("请输入密码",getPassword,password,true),
            clickButton("登录"),
          ],
        ),
      ),
    );
  }
}
void getUsername(){
  userData.username = username.text;
  print(userData.username);
}
void getPassword(){
  userData.password = password.text;
  print(userData.password);
}

