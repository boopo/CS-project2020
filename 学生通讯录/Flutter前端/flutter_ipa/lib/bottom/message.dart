import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';
import 'package:fluttertoast/fluttertoast.dart';
List data=[];
class message extends StatefulWidget{
  @override
  _message createState() => _message();
}
class _message extends State<message>{
  @override
  void initState() {
    super.initState();
    data = userData.userData;
    data.forEach((value) {
      nameList.add(value['name']);
    });
  }
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
    final scrHeight = MediaQuery.of(context).size.height;
    final scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrHeight*0.06),
        child:AppBar(
          leading: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0,0, 0, 0),
              child: IconButton(
                icon:Icon(Icons.search),
                color: Colors.black,
                onPressed: (){
                  showSearch(context: context,
                      delegate:search()
                  );
                },
              )
          ),
          centerTitle: true,
          actions: [
            Container(

              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: (){
                  Navigator.of(context).pushNamed('/addPage');
                },
              ),
            )
          ],
          elevation: 0,
          backgroundColor: white,
          title: Container(
            alignment: Alignment.center,
            width: scrWidth,
            child: Row(
              children: [
                Container(
                  width: scrWidth*0.60,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  alignment: Alignment.center,
                  child: Text("通讯录",style: TextStyle(color: Colors.black),),
                ),

              ],
            ),
          ),
        ),
      ),

      body: ListView.builder(
                itemCount: data.length,
                itemBuilder:(context,index){
                  return ListTile(
                    leading: Container(
                      child: Image.asset('images/bussiness-man.png'),
                    ),
                    title: Text(data[index]['name']),
                    subtitle: Text(data[index]['phone']),
                    trailing: Text(data[index]['stuNumber']),
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
                    onLongPress: (){
                      selectData.userId = data[index]['id'].toString();
                      selectData.stuNumber = data[index]['stuNumber'];
                      selectData.name = data[index]['name'];
                      selectData.qq = data[index]['qq'];
                      selectData.phone = data[index]['phone'];
                      selectData.mail = data[index]['mail'];
                      selectData.birthday = data[index]['birthday'];
                      selectData.age = data[index]['age'];
                      selectData.college = data[index]['college'];
                      selectData.address = data[index]['address'];
                      selectData.remarks = data[index]['remarks'];
                      selectData.sex = data[index]['sex'];
                      selectData.belong = data[index]['belong'];
                      setState(() {

                      });
                      showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                                title: Text("请选择你需要的操作"),
                                content:
                                Container(
                                  height: 160,
                                  width: 400,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text("修改信息"),
                                        onTap: (){
                                          userData.alterId = data[index]['id'].toString();
                                          Navigator.of(context).pushNamed('/alterInfo');
                                        },
                                      ),
                                      ListTile(
                                        title: Text("删除用户"),
                                        onTap: (){
                                          userData.deleteId = data[index]['id'].toString();
                                          data.removeAt(index);
                                          setState(() {
                                            deleUser();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      DropdownButton(
                                        hint:Text("当前分组："+data[index]['belong']) ,
                                       items:groupData.groupList.map(
                                               (e) {
                                       return DropdownMenuItem(
                                           value: e['groupName'],
                                            child:Text(e['groupName'])
                                  );
                                }
                                ).toList(),
                                        onTap: (){
                                          selectData.userId = data[index]['id'].toString();
                                          selectData.stuNumber = data[index]['stuNumber'];
                                          selectData.name = data[index]['name'];
                                          selectData.qq = data[index]['qq'];
                                          selectData.phone = data[index]['phone'];
                                          selectData.mail = data[index]['mail'];
                                          selectData.birthday = data[index]['birthday'];
                                          selectData.age = data[index]['age'];
                                          selectData.college = data[index]['college'];
                                          selectData.address = data[index]['address'];
                                          selectData.remarks = data[index]['remarks'];
                                          selectData.sex = data[index]['sex'];
                                          selectData.belong = data[index]['belong'];
                                          print(index);
                                        },
                                onChanged:(_){
                                  print(_);
                                  selectData.belong = _;
                                  alterUserInfo().then((value){
                                    getAllUsers();
                                    getGroup();
                                    setState(() {
                                      data[index]['belong'] = _;
                                      showRuturnToast("修改分组成功");
                                    });
                                          }
                                          );
                                  Navigator.of(context).pop();
                                } ,
                              )
                                    ],
                                  ),
                                )
                            );
                          }
                      );
                    },
                  );
                })
    );
  }
}

void getSelectData(){

}