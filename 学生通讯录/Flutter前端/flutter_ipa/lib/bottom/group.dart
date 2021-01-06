import 'package:flutter/material.dart';
import 'package:flutter_ipa/bottom/message.dart';
import 'package:flutter_ipa/color.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';
import 'package:fluttertoast/fluttertoast.dart';
class group extends StatefulWidget {

  group({Key key}) : super(key: key);
  @override
  _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
}

int select;
class _ExpansionPanelPageState extends State<group> {
  @override
  Widget build(BuildContext context) {

    void showDia(){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("请输入新建分组名字"),
              content: TextField(
                onChanged: (String value){
                  setState(() {
                    groupData.addGroupName = value;
                  });
                },
              ),
              actions:<Widget> [
                FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("再想想")),
                FlatButton(onPressed: (){
                    addGroup().then((value){
                    setState(() {
                      getGroup().then((value){
                        getAllUsers().then((value){
                          Navigator.of(context).pushNamed('/home');
                        });

                      });

                    }
                    );
                    });

                }, child: Text("我确认"))
              ],
            );
          }
      );
    }//确认展示信息框
    final scrHeight = MediaQuery.of(context).size.height;
    final scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrHeight*0.06),
        child:AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.black,
              onPressed: showDia
            ),
          ],
          elevation: 0,
          backgroundColor: white,
          title: Container(
            alignment: Alignment.center,
            width: scrWidth,
            child:Container(
              margin: EdgeInsets.fromLTRB(scrWidth*0.01, 0, 0, 0),
              alignment: Alignment.center,
              child: Text("分组信息",style: TextStyle(color: Colors.black),),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }
  Widget _buildPanel() {
    void showDele(){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("提示"),
              content: Text("确定要删除吗"),
              actions: <Widget>[
                FlatButton(
                    child: Text("取消"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                ),
                FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      print(groupData.deleGroupId);
                      deleGroup().then((value) {
                        setState(() {
                          getGroup();
                        });
                      });
                      Navigator.of(context).pop();
                    }
                ),
              ],
            );

          }
      );
    }
    return ExpansionPanelList(
      animationDuration: Duration(
        milliseconds: 600
      ),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          print(index);
          groupData.deleGroupId = groupData.groupList[index]['groupName'];
          selectData.groupName = groupData.groupList[index][''];
          groupData.groupList[index]['isExpanded'] = !groupData.groupList[index]['isExpanded'];
        });
      },
      children: groupData.groupList.map(
              (value) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(

                        title: Text(value['groupName']),
                      );
                    },
                    body: Container(
                      child: Column(
                        children: [
                          Container(
                            height: double.parse((value['userInfo'].length*80+15).toString()),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value['userInfo'].length,
                                itemBuilder:(context,index){
                                  return Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(5.0, 5.0), //阴影xy轴偏移量
                                          blurRadius: 10.0, //阴影模糊程度
                                          spreadRadius: 2.0 //阴影扩散程度
                                      ),],
                                      borderRadius: BorderRadius.circular(10),
                                      color: white
                                  ),
                                    child: ListTile(
                                      title: Text(value['userInfo'][index]['name']),
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
                                        setState(() {
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
                                          select = index;
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
                                                            userData.alterId = data[select]['id'].toString();
                                                            Navigator.of(context).pushNamed('/alterInfo');
                                                          },
                                                        ),
                                                        ListTile(
                                                          title: Text("删除用户"),
                                                          onTap: (){
                                                            userData.deleteId = data[select]['id'].toString();
                                                            deleUser().then((value){
                                                              setState(() {
                                                                getGroup();
                                                                getAllUsers();
                                                              });
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
                                                              setState(() {
                                                                getAllUsers();
                                                                getGroup();
                                                                showRuturnToast("修改分组成功");
                                                                Navigator.of(context).pushNamed('/home');
                                                              });
                                                            }
                                                            );

                                                          } ,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              );
                                            }
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon:Icon(Icons.clear),
                              onPressed: (){
                                showDele();
                              },
                            ),
                          )
                        ],
                      )
                    ),
                    isExpanded: value['isExpanded']
                );
              }
      ).toList()
    );
  }
}
showRuturnToast(String value){
  Fluttertoast.showToast(
      msg: value,
      gravity: ToastGravity.CENTER,
      textColor: Colors.black,
      backgroundColor: Colors.white,
      fontSize: 16
  );
}