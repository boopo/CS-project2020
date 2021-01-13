import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_puzzle/database/data.dart';
import 'package:flutter_puzzle/main.dart';


var loginUrl = 'https://api.kxz.atcumt.com/jwxt/login';
class R {
  static final String imagesAJpg = 'images/2.jpg';
  static final String imagesBPng = 'images/3.jpg';
  static final String imagesBackgroundJpg = 'images/background.jpg';
  static final String imagesCJpg = 'images/4.jpg';
  static final String imagesDJpg = 'images/5.jpg';
  static final String imagesEJpg = 'images/6.jpg';
  static final String imagesHomeJpg = 'images/home.jpg';
  static final String imageHome2 = 'images/1.jpg';
}

class loginTextField extends StatelessWidget{
  final String text;
  final TextEditingController controller;
  final void Function() getInput;
  final bool isSecurity;
  const loginTextField(this.text,this.getInput,this.controller,this.isSecurity,{Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      width: 280,
      decoration: BoxDecoration(
          color: loginTFColor,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: new Border.all(color: Colors.white)
      ),
      child: TextField(
        onChanged: (value){
          getInput();
        },
        onSubmitted: (value){
          print("这是submitted："+value);
        },
        controller: controller,
        textAlign: TextAlign.center,
        obscureText: isSecurity,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
        ),
      ),
    );
  }
}//登录页面输入框
var loginText = TextStyle(color: Colors.white,fontSize: 18);//登录按钮样式
class clickButton extends StatelessWidget{
  final String text;

  const clickButton(this.text,{Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
      width: 200,
      height: 40,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(text,style: loginText),
        color: loginButtonColor,
        onPressed: ()async{
            Response response = await Dio().post(
                loginUrl,
                data: {
                  'username':userData.username,
                  'password':userData.password
                }
            );
            var res = json.decode(json.encode(response.data));
            print(res["code"]);
            if(res["code"] == 0){
              isLogin = true;
              Navigator.of(context).pushReplacementNamed('/home');
            }
            print("1");
        },
      ),
    );
  }
}//登陆页面按钮

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
final Color loginTFColor = HexColor("#f3f3f3");//灰色颜色
Color loginButtonColor = HexColor("#00dc9c");//登录按钮颜色
final Color white  = HexColor("#ffffff");