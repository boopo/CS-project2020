import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/module.dart';
import 'package:flutter_ipa/data.dart';
class user_page extends StatefulWidget{
  @override
  _user createState() => _user();
}

class _user extends State<user_page>{
  @override
  Widget build(BuildContext context) {
    final scrWid = MediaQuery.of(context).size.width;
    final scrHei  = MediaQuery.of(context).size.height;
    return Container(
      width: scrWid,
      height: scrHei,
      alignment: Alignment.center,
      child:Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(scrHei*0.06),
          child:AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: white,
            title: Container(
              alignment: Alignment.center,
              width: scrWid,
              child: Text("个人信息",style: TextStyle(
                color: Colors.black
              ),)
            ),
          ),
        ),
        body: userInfo(
          username: userData.username,
          grade: userData.classname,
          college: userData.college,
          name: userData.name,
        ),
      )
    );
  }
}