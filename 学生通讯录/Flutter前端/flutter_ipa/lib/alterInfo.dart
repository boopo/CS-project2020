import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';

class alterInfo extends StatefulWidget{
  @override
  _alter createState() => _alter();
}

class _alter extends State<alterInfo>{
  TextEditingController usernameControll = new TextEditingController(text: selectData.stuNumber);
  TextEditingController nameControll = new TextEditingController(text: selectData.name);
  TextEditingController birthdayControll = new TextEditingController(text: selectData.birthday);
  TextEditingController addressControll = new TextEditingController(text: selectData.address);
  TextEditingController QQControll = new TextEditingController(text: selectData.qq);
  TextEditingController mailControll  = new TextEditingController(text: selectData.mail);
  TextEditingController phoneControll = new TextEditingController(text: selectData.phone);
  TextEditingController remarksControll = new TextEditingController(text: selectData.remarks);
  TextEditingController collegeControll = new TextEditingController(text: selectData.college);
  TextEditingController belongControll = new TextEditingController(text: selectData.belong);
  TextEditingController sexControll = new TextEditingController(text: selectData.sex);
  void inputSex(){
    selectData.sex = sexControll.text;
  }
  void inputBelong(){
    selectData.belong  = belongControll.text;
  }
  void inputUsername(){
    selectData.stuNumber = usernameControll.text;
  }
  void inputName(){
    selectData.name = nameControll.text;
  }
  void inputBirthday(){
    selectData.birthday = birthdayControll.text;
  }
  void inputAddress(){
    selectData.address = addressControll.text;
  }
  void inputQQ(){
    selectData.qq = QQControll.text;
  }
  void inputMail(){
    selectData.mail = mailControll.text;
  }
  void inputPhone(){
    selectData.phone = phoneControll.text;
  }
  void inputCollege(){
    selectData.college = collegeControll.text;
  }
  void inputDescription(){
    selectData.remarks = remarksControll.text;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(selectData.name);

  }
  @override
  Widget build(BuildContext context) {
    final scrHei  = MediaQuery.of(context).size.height;
    final scrWid  = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(scrHei*0.06),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: white,
            elevation: 0,
            title: Container(
              child: Row(
                children: [
                  IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back_rounded), onPressed:(){
                    Navigator.of(context).pop();
                  }),
                  Container(
                    width: scrWid*0.72,
                    height: scrHei,
                    alignment: Alignment.center,
                    child: Text("修改信息",style: TextStyle(color: Colors.black),),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,

          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: scrWid*0.8,
                alignment: Alignment.centerLeft,
                child: Text("请输入修改后的用户信息",style: TextStyle(fontSize: 16,color: Colors.grey),),
              ),
              Container(
                height: scrHei*0.8,
                width:scrWid*0.8,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5.0, 10.0), //阴影xy轴偏移量
                        blurRadius: 10.0, //阴影模糊程度
                        spreadRadius: 2.0 //阴影扩散程度
                    ),],
                    borderRadius: BorderRadius.circular(20),
                    color: white
                ),

                child: SingleChildScrollView(
                    child:Column(
                      children: [
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/username.png",
                          hinText: "输入学号",
                          labText: "学号",
                          controller: usernameControll,
                          input: inputUsername,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/account.png",
                          hinText: "输入姓名",
                          labText: "姓名",
                          controller: nameControll,
                          input: inputName,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/sex.png",
                          hinText: "输入性别",
                          labText: "性别",
                          controller: sexControll,
                          input:inputSex,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/birthday.png",
                          hinText: "输入生日：格式为xxxx/xx/xx",
                          labText: "生日",
                          controller: birthdayControll,
                          input:inputBirthday,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/address.png",
                          hinText: "输入地址",
                          labText: "地址",
                          controller: addressControll,
                          input: inputAddress,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/QQ.png",
                          hinText: "输入QQ号",
                          labText: "QQ",
                          controller: QQControll,
                          input: inputQQ,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/mail.png",
                          hinText: "输入邮箱",
                          labText: "邮箱",
                          controller: mailControll,
                          input: inputMail,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/phone.png",
                          hinText: "输入号码",
                          labText: "号码",
                          controller: phoneControll,
                          input: inputPhone,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/college.png",
                          hinText: "输入学院",
                          labText: "学院",
                          controller: collegeControll,
                          input: inputCollege,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/grade.png",
                          hinText: "属于分组",
                          labText: "分组",
                          controller: belongControll,
                          input: inputBelong,
                        ),
                        inputTextField(
                          conHei: 80,
                          conWid: scrWid*0.8,
                          src: "images/description.png",
                          hinText: "输入描述",
                          labText: "描述",
                          controller: remarksControll,
                          input: inputDescription,
                        ),
                        FlatButton(
                            onPressed: (){
                              alterUserInfo().then((value){
                                getAllUsers().then((value){
                                  getGroup().then((value){
                                    Navigator.of(context).pushNamed('/home');
                                  });
                                });


                              });

                            }, child: Text(
                            "确定"
                        )
                        )
                      ],
                    )
                ),
              ),
            ],
          ),

        )
    );
  }

}

