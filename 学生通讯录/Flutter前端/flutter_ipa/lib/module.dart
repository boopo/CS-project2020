import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/searchPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_ipa/data.dart';

class charaCard extends StatelessWidget{
  final String name;
  final String phone;
  final String qq;
  final String grade;
  @override
  const charaCard(this.name,this.grade,this.phone,this.qq,{Key key}):super(key : key);
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 60,
      child: InkWell(
        onTap: (){
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset('images/bussiness-man.png',fit: BoxFit.cover,),
            ),
            Container(
              child: Column(
                children: [
                  Text(name,style: TextStyle(fontSize: 16),),
                  Text(phone,style: TextStyle(fontSize: 12),),
                  Text(qq,style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            Expanded(
                child: Container(
                   alignment: Alignment.centerRight,
                  child: Icon(Icons.phone),
            ))
          ],
        ),
      ),
    );
  }

}


class userInfo extends StatefulWidget{
  final String name;
  final String college;
  final String grade;
  final String username;
  final String phone;
  const userInfo({Key key,this.name,this.phone,this.username,this.grade,this.college});
  @override
  _userInfo createState() => _userInfo();
}//个人信息页

class _userInfo extends State<userInfo>
{

  @override
  Widget build(BuildContext context) {
    final scrWid = MediaQuery.of(context).size.width;
    final scrHei  = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child:Container(
        alignment: Alignment.center,
        width: scrWid*0.9,
        height: scrHei*0.4,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(5.0, 5.0), //阴影xy轴偏移量
                blurRadius: 10.0, //阴影模糊程度
                spreadRadius: 2.0 //阴影扩散程度
            ),],
        ),
        child: Center(
          child:ListView(
          children: [
            ListTile(
              leading: Text("姓名"),
              title: Text(widget.name),
            ),
            ListTile(
              leading: Text("学号"),
              title: Text(widget.username),
            ),
            ListTile(
              leading: Text("年级"),
              title: Text(widget.college),
            ),
            ListTile(
              leading: Text("班级"),
              title: Text(widget.grade),
            ),
          ],
        ),)
      )
    );
  }
}

class infoPage extends StatefulWidget{
  final String name;
  final String grade;
  final String qq;
  final String phone;
  final String address;
  final String mail;
  final String belong;
  final String birthday;
  final String age;
  final String sex;
  final String stuNumber;

  const infoPage({Key key,this.mail,this.address,this.birthday,this.sex,this.belong,
  this.stuNumber,this.age,
  this.name,this.grade,this.qq,this.phone}):super(key: key);
  @override
  info_page createState() => info_page();
}

class info_page extends State<infoPage> with SingleTickerProviderStateMixin{
@override
  Widget build(BuildContext context) {
    final scrWid = MediaQuery.of(context).size.width;
    final scrHei  = MediaQuery.of(context).size.height;
      return Scaffold(
        appBar:AppBar(
          automaticallyImplyLeading: false,
              title:Container(
                child: Text("信息卡片",style: TextStyle(fontSize: 20),),
                width: scrWid,
                alignment: Alignment.center,
                /*decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/back.jpg')
                    )
                ),*/
              ),
        ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Column(
              children: [
                Divider(color: Colors.black,thickness: 1.0,),
                Container(
                  width: scrWid*0.9,
                  height: scrHei*0.8,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Text("姓名"),
                        title: Text(widget.name),
                      ),
                      ListTile(
                        leading: Text("年龄"),
                        title: Text(widget.age),
                      ),
                      ListTile(
                        leading:Text("性别"),
                        title: Text(widget.sex),
                      ),
                      ListTile(
                        leading: Text("生日"),
                        title: Text(widget.birthday),
                      ),
                      ListTile(
                        leading: Text("学号"),
                        title: Text(widget.stuNumber),
                      ),
                      ListTile(
                        leading: Text("班级"),
                        title: Text(widget.grade),
                      ),
                      ListTile(
                        leading: Text("地址"),
                        title: Text(widget.address),
                      ),
                      ListTile(
                        leading: Text("QQ"),
                        title: Text(widget.qq),
                      ),
                      ListTile(
                        leading: Text("邮箱"),
                        title: Text(widget.mail),
                      ),
                      ListTile(
                        leading: Text("电话"),
                        title: Text(widget.phone),
                        subtitle: Text("长按拨打电话"),
                        onLongPress: (){
                          launch("tel://"+widget.phone);
                        },
                      ),
                      ListTile(
                        leading: Text("属于分组"),
                        title: Text(widget.belong),
                      )
                    ],
                  ),
                )
              ],

            ),
          ),
      );
  }
}

class packListTile extends StatelessWidget{
  final double Conheight;
  final double Conwidth;
  final String lead;
  final String titText;
  final Function() click;
  @override
  const packListTile({Key key,this.Conheight,this.Conwidth,this.lead,this.click,this.titText,}):super(key: key);
  Widget build(BuildContext context){
    return Container(
      width: Conwidth,
      height: Conheight,
      child: Row(
        children: [
          Container(
            height: Conheight,
            width: Conwidth*0.2,
            child: Text(lead),
          ),
          Container(
            height: Conheight,
            width: Conwidth*0.4,
            child: Text(titText),
          ),
        ],
      ),
    );
  }
}

class inputTextField extends StatelessWidget{
  final double conHei;
  final double conWid;
  final String src;
  final String labText;
  final String hinText;
  final Function() input;
  final TextEditingController controller;
  const inputTextField({Key key,this.controller,this.input,this.conHei,this.conWid,this.src,this.hinText,this.labText}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: conWid,
      height: conHei,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            width: conWid*0.1,
            height: conHei*0.6,
            child: Image.asset(src,fit: BoxFit.fitWidth,),
          ),
          Container(
            width: conWid*0.7,
            height: conHei,
            child: TextField(
              controller: controller,
              onChanged: (value){
                input();
              },
              decoration: InputDecoration(
                hintText: hinText,
                labelText: labText
              ),
            ),
          )
        ],
      ),
    );
  }
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
  final Function() click;
  const clickButton(this.click,this.text,{Key key}):super(key:key);
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
        onPressed: (){
          click();
        },
      ),
    );
  }
}//登陆页面按钮

List nameList = [];

class search extends SearchDelegate<String>{
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => "输入姓名";
  Future get()async{
    searchInfo.searchName= query;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }
  @override
  Widget buildResults(BuildContext context) {
    return search_page();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final dataList = query.isEmpty? nameList:[] ;
    searchInfo.searchName = query;
     get().then((value){
      searchData();
    });
    return search_page();
    /*ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context,index) => ListTile(
          title: RichText(
            text: TextSpan(
              text:data[index]['name'],
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>infoPage(
                  name: data[index]['name'],
                  grade: data[index]['college'],
                  qq: data[index]['qq'],
                  phone: data[index]['phone'],
                  birthday: data[index]['birthday'],
                  belong: data[index]['belong'],
                  address: data[index]['address'],
                  sex: data[index]['sex'],
                  mail: data[index]['mail'],
                  age: data[index]['age'],
                  stuNumber: data[index]['stuNumber'],
                )));
          },
        )
    );*/
  }
}