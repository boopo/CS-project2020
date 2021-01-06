import 'package:flutter/material.dart';
import 'package:flutter_ipa/data.dart';
import 'package:flutter_ipa/http.dart';
import 'package:flutter_ipa/module.dart';

class search_page extends StatefulWidget{
  @override
  _search createState() => _search();
}

class _search extends State<search_page>{
  @override
  void initState() {
    super.initState();
    setState(() {
      searchData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: searchInfo.getSearch.length,
          itemBuilder: (context,index) => ListTile(
            title: RichText(
              text: TextSpan(
                  text:searchInfo.getSearch[index]['name'],
                style: TextStyle(color: Colors.black)
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>infoPage(
                    name: searchInfo.getSearch[index]['name'],
                    grade: searchInfo.getSearch[index]['college'],
                    qq: searchInfo.getSearch[index]['qq'],
                    phone: searchInfo.getSearch[index]['phone'],
                    birthday: searchInfo.getSearch[index]['birthday'],
                    belong: searchInfo.getSearch[index]['belong'],
                    address: searchInfo.getSearch[index]['address'],
                    sex: searchInfo.getSearch[index]['sex'],
                    mail: searchInfo.getSearch[index]['mail'],
                    age: searchInfo.getSearch[index]['age'],
                    stuNumber: searchInfo.getSearch[index]['stuNumber'],
                  )));
            },
          )
      )
    );
  }
}