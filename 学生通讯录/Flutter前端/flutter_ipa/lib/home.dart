import 'package:flutter/material.dart';
import 'package:flutter_ipa/bottom/group.dart';
import 'package:flutter_ipa/bottom/message.dart';
import 'package:flutter_ipa/bottom/myData.dart';
import 'package:flutter_ipa/http.dart';
class home_page extends StatefulWidget{
  @override
  home createState() => home();
}

int _currentIndex = 0;
class home extends State<home_page>
{
  PageController pageController = new PageController(initialPage: 0);
  void tapHandler(int index){
    pageController.animateToPage(
        index, duration: Duration(milliseconds:100), curve: Curves.ease);
  }
  void pageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  List page = [message(),group(),myData()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getAllUsers().then((value){
     getGroup().then((value){
       initState();
     });
   });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        onTap: tapHandler,
        items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.phone),
              label: "通讯"
            ),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
            label: "分组"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
            label: "我的"
          )
        ],
      ),
      body: PageView.builder(
        onPageChanged: pageChanged,
        controller: pageController,
        itemCount: page.length,
        itemBuilder: (BuildContext context,int index){
          return page[index];
        },
      )
      );
  }
}