import 'package:flutter/material.dart';
import 'package:flutter_puzzle/database/data.dart';
import 'package:flutter_puzzle/r.dart';
import 'package:flutter_puzzle/database/database_helper.dart';
import 'package:flutter_puzzle/models/rank.dart';
/*

showRankDialog(BuildContext context, TickerProvider tickerProvider, List<String> levels){
	showDialog(
			context: context,
			builder: (context){
				TabController tabController = TabController(length: levels.length, vsync: tickerProvider);
				return AlertDialog(
						content: Column(
							mainAxisSize: MainAxisSize.min,
							children: <Widget>[
								Text("排行榜", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18),),
								//		Container(height: 10,),
								TabBar(
									controller: tabController,
									tabs: levels.map((e){
										//	return Text(e, style: TextStyle(color: Colors.black, fontSize: 16),);
										return Tab(child: Text(e, style: TextStyle(color: Colors.black, fontSize: 16),),);
									}).toList(),
								),
								Container(
									//			color: Colors.green,
									width: MediaQuery.of(context).size.width,
									height: 100,
									child: TabBarView(
										controller: tabController,
										children: <Widget>[
											_rank(1),
											_rank(2),
											_rank(3),
										],
									),
								),
								RaisedButton(
									onPressed: (){
										Navigator.of(context).pop();
									},
									child: Text("确定"),
								),
								FlatButton(
									padding: EdgeInsets.all(0),
									onPressed: (){
										DatabaseHelper.instance.delete();
										Navigator.of(context).pop();
									},
									child: Text("清空排行榜", style: TextStyle(color: Colors.blue),),
								),
							],
						)
				);
			}
	);
}

Widget _rank(int level){
	return Column(
		mainAxisSize: MainAxisSize.min,
		children: <Widget>[
			Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Expanded(child: Text("名次", textAlign: TextAlign.center,)),
					Expanded(child: Text("昵称", textAlign: TextAlign.center,)),
					Expanded(child: Text("成绩", textAlign: TextAlign.center,)),
					Expanded(flex: 2,child: Text("日期", textAlign: TextAlign.center,)),
				],
			),
			FutureBuilder<
					List<Rank>>
				(
					future: DatabaseHelper.instance.searchThree(level),
					builder: (context, snapshot){
						if(snapshot.connectionState == ConnectionState.done){
							if(snapshot.hasData){
								return Column(
									mainAxisSize: MainAxisSize.min,
									children: snapshot.data.map((e){
										return Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: <Widget>[
												Expanded(child: Text((snapshot.data.indexOf(e) + 1).toString(), textAlign: TextAlign.center,)),
												Expanded(child: Text("e.name", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)),
												Expanded(child: Text(Duration(milliseconds: e.score).toString().substring(2, 7), textAlign: TextAlign.center,)),
												Expanded(flex: 2, child: Text(e.time.substring(0, 10), textAlign: TextAlign.center,)),
											],
										);
									}).toList(),
								);
							}else{
								return Center(
									child: Text("没有数据！"),
								);
							}
						}else{
							return Container();
						}
					}),
		],
	);
}
//显示排行榜dialog
 */
class dialog extends StatefulWidget{
	@override
	_dialog createState() => _dialog();
}

class _dialog extends State<dialog> with SingleTickerProviderStateMixin{
	@override
	TabController _controller;
	void initState() {
    // TODO: implement initState
		super.initState();
		_controller = new TabController(length: 2,vsync:this);
		_controller.addListener(() {
		print("11");
		});

  }
	@override
	Widget build(BuildContext context) {
		final scrHei  = MediaQuery.of(context).size.height;
		final scrWid  = MediaQuery.of(context).size.width;
    return Scaffold(
			body: TabBarView(
				controller: _controller,
				children: <Widget>[
					rank_page(),
					time_page()
				],
			),
			appBar: PreferredSize(
				preferredSize: Size.fromHeight(scrHei*0.06),
				child: AppBar(
					bottom: TabBar(
						labelColor: Colors.black,
						labelStyle: TextStyle(color: Colors.black),
						controller: _controller,
						tabs: <Widget>[

							Tab(text: "积分排行榜",),
							Tab(text: "所用时间数据",)
						],
					),
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
									child: Text("排行榜",style: TextStyle(color: Colors.black),),
								)
							],
						),
					),
				),
			),
		);
  }
}

class time_page extends StatefulWidget{
	@override
	_time createState()=> _time();
}

class _time extends State<time_page>{
	@override
	Widget build(BuildContext context) {
    return Container(
			child: ListView.builder(
				itemCount: rank.timeList.length,
					itemBuilder: (context,index){
					return Column(
						children: [
							Container(
								alignment: Alignment.center,
								child: Text(rank.timeList[index]['username']),
							),
							ListTile(
								title: Text("初级通关时间："+rank.timeList[index]['time_a'].toString()),
							),
							ListTile(
								title: Text("中级通关时间："+rank.timeList[index]['time_b'].toString()),
							),
							ListTile(
								title: Text("高级通关时间："+rank.timeList[index]['time_c'].toString()),
							),
						],
					);
					}),
		);
  }
}

class rank_page extends StatefulWidget{
	@override
	_rank createState()=> _rank();
}

class _rank extends State<rank_page>{
	@override
	Widget build(BuildContext context) {
		return Container(
				child: ListView.builder(
						itemCount: rank.scoreList.length,
						itemBuilder:(context,index){
							return ListTile(
								leading: Text("第"+(index+1).toString()+"名"),
								title: Text("学号："+rank.scoreList[index]['username']),
								subtitle: Text("积分："+rank.scoreList[index]['rank'].toString()),
							);
						}),
		);
	}
}