
class GlobalUserData{
  String id;
  String username;
  String password;
  String name;
  String token;
  String classname;
  String college;
  String qq;
  String mail;
  String phone;
  String description;
  String address;
  String data;
  String deleteId;
  String alterId;
  String birthday;
  String belong;
  List userData;
  String sex;
  List groupNameList;
  List userDataLast;
  List groupNameListLast;
}

class addInfo{
  String stuNumber;
  String name;
  String sex;
  String age;
  String birthday;
  String address;
  String qq;
  String mail;
  String college;
  String belong;
  String phone;
  String remarks;
  String username;
  String classname;
}

class Group{
  var groupInfo ={};
  List groupList =[];
  List groupListLast =[];
  String addGroupName;
  String deleGroupId;
}

class selectInfo{
  String stuNumber;
  String name;
  String sex;
  String age;
  String birthday;
  String address;
  String qq;
  String mail;
  String college;
  String belong;
  String phone;
  String remarks;
  String userId;
  String groupId;
  String groupName;
}

class search_data{
  String searchName;
  List getSearch;
}
search_data searchInfo = new search_data();
selectInfo selectData = new selectInfo();
Group groupData = new Group();
addInfo addData = new addInfo();
GlobalUserData userData = new GlobalUserData();