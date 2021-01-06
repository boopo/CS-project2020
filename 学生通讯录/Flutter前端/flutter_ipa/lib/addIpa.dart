import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';

class addIpa extends StatefulWidget{
  @override
  _addPage createState() => _addPage();
}

TextEditingController usernameControll = new TextEditingController();
TextEditingController nameControll = new TextEditingController();
TextEditingController birthdayControll = new TextEditingController();
TextEditingController addressControll = new TextEditingController();
TextEditingController QQControll = new TextEditingController();
TextEditingController mailControll  = new TextEditingController();
TextEditingController phoneControll = new TextEditingController();
TextEditingController remarksControll = new TextEditingController();
TextEditingController collegeControll = new TextEditingController();
TextEditingController belongControll = new TextEditingController();
TextEditingController sexControll = new TextEditingController();
TextEditingController ageControll = new TextEditingController();
void inputSex(){
  addData.sex = sexControll.text;
}
void inputAge(){
  addData.age = ageControll.text;
}
void inputBelong(){
  addData.belong  = belongControll.text;
}
void inputUsername(){
  addData.stuNumber = usernameControll.text;
}
void inputName(){
  addData.name = nameControll.text;
}
void inputBirthday(){
  addData.birthday = birthdayControll.text;
}
void inputAddress(){
  addData.address = addressControll.text;
}
void inputQQ(){
  addData.qq = QQControll.text;
}
void inputMail(){
  addData.mail = mailControll.text;
}
void inputPhone(){
  addData.phone = phoneControll.text;
}
void inputCollege(){
  addData.college = collegeControll.text;
}
void inputDescription(){
  addData.remarks = remarksControll.text;
}
class _addPage extends State<addIpa>{
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
                  child: Text("添加用户",style: TextStyle(color: Colors.black),),
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
                  child: Text("请输入您需要添加的用户信息",style: TextStyle(fontSize: 16,color: Colors.grey),),
                ),
                Container(
                  height: scrHei*0.8,
                  width:scrWid*0.8,

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
                        src: "images/age.png",
                        hinText: "输入年龄",
                        labText: "年龄",
                        controller: ageControll,
                        input: inputAge,
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
                        src: "images/college.png",
                        hinText: "输入学院",
                        labText: "学院",
                        controller: collegeControll,
                        input: inputCollege,
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
                          addUser().then((value)  {
                            getAllUsers();
                            getGroup();
                            Navigator.of(context).pushNamed('/home');
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

