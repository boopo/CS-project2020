import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/module.dart';

class about extends StatefulWidget{
  @override
  _about createState() => _about();
}

class _about extends State<about>{
  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.of(context).size.height;
    final scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrHeight*0.06),
        child:AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: white,
          title: Container(
            alignment: Alignment.center,
            width: scrWidth,
              child: Text("作者信息",style: TextStyle(color: Colors.black),),
          ),
        ),
      ),
      body: Container(
      alignment: Alignment.center,
          child: Column(
        children: [
          Text("前端"),
            userInfo(
              name: "王逸鸣",
              username: "08192942",
              grade: "计科二班",
              college: "计算机科学与技术学院",
            ),
          Text("后端"),
          userInfo(
            name: "吕迎朝",
            username: "08192942",
            grade: "大数据一班",
            college: "计算机科学与技术学院",
          )
      ],
    ),
      ),
    );
  }
}