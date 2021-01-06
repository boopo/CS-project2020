import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
class myData extends StatefulWidget{
  @override
  _myData createState() => _myData();
}

class _myData extends State<myData>
{
  @override
  Widget build(BuildContext context) {

     showRuturnToast(String value){
      Fluttertoast.showToast(
          msg: value,
          gravity: ToastGravity.CENTER,
          textColor: Colors.black,
          backgroundColor: Colors.white,
        fontSize: 16
      );
    }
    final scrHei = MediaQuery.of(context).size.height;
    final scrWid = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
          body: Container(
            height: scrHei,
            width: scrWid,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: scrHei*0.3,
                  width: scrWid,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage('images/back2.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Container(
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: new Border.all(width: 0.5,color: Colors.black),
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  image: AssetImage('images/PIC.jpg',),
                                  fit: BoxFit.fitWidth
                                )
                              ),

                            ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text("王逸鸣",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, scrHei*0.005, 0, 0),
                    width: scrWid*0.9,
                    height: scrHei*0.6,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5.0, 5.0), //阴影xy轴偏移量
                            blurRadius: 5.0, //阴影模糊程度
                            spreadRadius: 2.0 //阴影扩散程度
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListView(
                      children: [
                        ListTile(
                        leading: Icon(Icons.backup_outlined),
                        title: Text("备份"),
                        onTap: (){
                              backup().then((value){
                                setState(() {
                                  showRuturnToast('备份成功');
                                });
                              });

                        },
                      ),
                        ListTile(
                          leading: Icon(Icons.keyboard_return),
                          title: Text("恢复"),
                          onTap: (){
                              recover().then((value){
                                setState(() {
                                  showRuturnToast('恢复成功');
                                });
                              });


                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_box_outlined),
                          title: Text("个人信息"),
                          onTap: (){
                            Navigator.of(context).pushNamed('/userData');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text("关于"),
                          onTap: (){
                              Navigator.of(context).pushNamed('/about');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.login),
                          title: Text("退出登录"),
                          onTap: (){
                              Navigator.of(context).pushReplacementNamed('/login');
                          },
                          ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}

Future backup()async{
  groupData.groupListLast = groupData.groupList;
  userData.groupNameListLast = userData.groupNameList;
  userData.userDataLast = userData.userData;
}

Future recover()async{
  groupData.groupList = groupData.groupListLast ;
  userData.groupNameList = userData.groupNameListLast ;
  userData.userData = userData.userDataLast ;
}
