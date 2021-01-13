import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_puzzle/models/rank.dart';

class User{
  String username;
  String password;

}

class rankData{
  List<dynamic> scoreList;
  List<dynamic> timeList;

  Future getRank()async{
    Response response  =  await Dio().get('https://www.lvyingzhao.cn/puzzle/time');//时间
    Response response1 = await Dio().get('https://www.lvyingzhao.cn/puzzle/rank');//等级
    var timeRank = json.decode(json.encode(response.data));
    var allRank = json.decode(json.encode(response1.data));
    print(timeRank);
    print(allRank);
    timeList  =  timeRank['data'];
    scoreList = allRank['data'];
    print(timeList);
    print(scoreList);
  }
}
rankData rank = new rankData();
User userData = new User();

