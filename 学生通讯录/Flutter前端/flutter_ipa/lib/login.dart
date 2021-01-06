import 'package:flutter/material.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';
import 'dart:convert';

class login_page extends StatefulWidget{
  @override
  _login createState() => _login();
}
TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();
class _login extends State<login_page>{
  @override
  void initState() {
    super.initState();
    getAllUsers();
    getGroup();
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
            clickButton(login,"登录"),
            clickButton(goHome,"试用")
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