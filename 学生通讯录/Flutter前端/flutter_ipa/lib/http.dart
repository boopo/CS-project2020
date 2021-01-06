import 'package:dio/dio.dart';
import 'package:flutter_ipa/bottom/group.dart';
import 'package:flutter_ipa/data.dart';
import 'dart:convert';
import 'package:flutter_ipa/main.dart';

var loginUrl = 'https://api.kxz.atcumt.com/jwxt/login';

goHome(){
  MyApp.navigator.currentState.pushReplacementNamed('/home');
}
login() async{
  try{
    Response response = await Dio().post(loginUrl,
        data: {
    'username':userData.username,
    'password':userData.password
    }
    );
    var res = json.decode(json.encode(response.data));
    userData.name = res["data"]["name"];
    userData.classname = res["data"]["classname"];
    userData.token = res["data"]["token"];
    userData.college = res["data"]["college"];
    if(res["code"] == 0){
      MyApp.navigator.currentState.pushReplacementNamed('/home');
    }
  }catch(e){
    print(e.toString());
  }
}
Future getAllUsers()async{
  Response response = await Dio().get('https://www.lvyingzhao.cn/phone_books');
  var data = json.decode(json.encode(response.data));
  userData.userData = data['data'];

  print(userData.userData);
}
Future readUser() async{
  Response response = await Dio().get('https://www.lvyingzhao.cn/phone_book/'+userData.id);
  print(response);
}

Future addUser()async{
  try{
    Response response = await Dio().post('https://www.lvyingzhao.cn/phone_books',
      data:{
        "stuNumber":addData.stuNumber,
        "name":addData.name,
        "sex":addData.sex,
        "age":addData.age,
        "birthday":addData.birthday,
        "address":addData.address,
        "qq":addData.qq,
        "mail":addData.mail,
        "college":addData.college,
        "phone":addData.phone,
        "belong":addData.belong,
        "remarks":addData.remarks
      },
    );
    groupData.addGroupName = addData.belong;
    showRuturnToast("添加成功");
  }catch(e){
    showRuturnToast('有信息错误');
   print("失败");
  }
}
Future addGroup()async{
  try{
    Response response = await Dio().post('https://www.lvyingzhao.cn/phone_category',
        data: {
          "belong":groupData.addGroupName
        });
    showRuturnToast("添加成功");
  }catch(e){
    showRuturnToast("添加失败，请检查是否有信息错误");
  }

}
Future getGroup()async{
  Response response = await Dio().get('https://www.lvyingzhao.cn/phone_category');
  var data = json.decode(json.encode(response.data));
  groupData.groupInfo = data['data'];
  groupData.groupList = data['data']['userList'];

  groupData.groupList.forEach((value) {
    value['isExpanded'] = false;
  });

}

Future deleUser() async{
  Response response = await Dio().delete(
    'https://www.lvyingzhao.cn/phone_book/'+userData.deleteId,
  );
  print(response.data);
  print("渲染成功");
}
Future alterUserInfo() async{
  try{
    Response response = await Dio().put('https://www.lvyingzhao.cn/phone_book/'+selectData.userId,
        data: {
          "stuNumber":selectData.stuNumber,
          "name":selectData.name,
          "sex":selectData.sex,
          "age":selectData.age,
          "birthday":selectData.birthday,
          "address":selectData.address,
          "qq":selectData.qq,
          "mail":selectData.mail,
          "college":selectData.college,
          "belong":selectData.belong,
          "phone":selectData.phone,
          "remarks":selectData.remarks
        }
    );
    groupData.addGroupName = selectData.belong;
    showRuturnToast("修改成功");
    getAllUsers();
    getGroup();
  }catch(e){
    showRuturnToast("修改失败，请检查是否存在信息填写错误");
  }
}
Future deleGroup()async{
  Response response = await Dio().delete('https://www.lvyingzhao.cn/phone_category',
  data: {
    "belong":groupData.deleGroupId
  }
  );
}

Future searchData()async{
  Response response = await Dio().get('https://www.lvyingzhao.cn/phone_search?name='+searchInfo.searchName);
  var data = json.decode(json.encode(response.data));
  searchInfo.getSearch = data['data'];
}

Future alterGroupName()async{
  Response response = await Dio().put('https://www.lvyingzhao.cn/phone_category',
  data: {
    "id":selectData.groupId,
    "belong":selectData.groupName
  }
  );
}

