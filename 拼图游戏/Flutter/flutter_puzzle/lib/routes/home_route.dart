import 'package:flutter/material.dart';
import 'package:flutter_puzzle/audio/audio.dart';
import 'package:flutter_puzzle/audio/audio_url.dart';
import 'package:flutter_puzzle/database/data.dart';
import 'package:flutter_puzzle/database/database_helper.dart';
import 'package:flutter_puzzle/dialogs/dialog.dart';
import 'package:flutter_puzzle/widgets/shine_effect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_puzzle/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../r.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeRouteState createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> with WidgetsBindingObserver, TickerProviderStateMixin{

	int level;
	List<String> levels;
	List<String> titles;
	int title;
	String imagePath;

	@override
	void initState() {
		super.initState();
		levels = <String>["初级", "中级", "高级"];
		level = 0;

		title = 0;
		titles = ["样例1", "样例2", "样例3", "样例4", "样例5"];


		Audio.instance.loop(AudioUrl.home);
		//增加监听生命周期
		WidgetsBinding.instance.addObserver(this);
	}

	@override
  Widget build(BuildContext context) {
  	Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
		    decoration: BoxDecoration(
					image: DecorationImage(
						image: AssetImage(R.imageHome2),
						fit: BoxFit.cover,
					),
		    ),
		    child: Column(
		    children: <Widget>[
          Container(
	          margin: EdgeInsets.only(top: size.height*0.15),
				    decoration: ShapeDecoration(
					//    color: Colors.green,
					    shape: BeveledRectangleBorder(
						    side: BorderSide(
							    color: Colors.white,
							    width: 3
						    ),
						    borderRadius: BorderRadius.circular(20),
					    ),
				    ),
	          width: 300,
	          height: 100,
	          child: Stack(
	            alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
										child: Text(
											"拼图游戏",
											style: TextStyle(
												/*fontFamily: "webfont",*/
													fontSize: 48,
													color: Colors.black
											),
										),
									)
                ),
								ClipPath(
									clipper: ShapeBorderClipper(
										shape: BeveledRectangleBorder(
											side: BorderSide(
													color: Colors.white,
													width: 3
											),
											borderRadius: BorderRadius.circular(20),
										),
									),
									child: ShineEffect(),
								),
              ],
            ),
          ),
			    Container(height: size.height*0.15,),
			    Column(
				    crossAxisAlignment: CrossAxisAlignment.start,
			      children: <Widget>[
			        Row(
				        mainAxisSize: MainAxisSize.min,
			          children: <Widget>[
			            Text("可选等级：",
								    style: TextStyle(
									    fontSize: 28,
									    color: Colors.white
								    ),
			            ),
					        DropdownButtonHideUnderline(
					          child: DropdownButton(
								      value: level,
								      items: levels.map((e){
								        return DropdownMenuItem(
										      value: levels.indexOf(e),
									        child: DefaultTextStyle(
										        textAlign: TextAlign.center,
										        style: TextStyle(
											        fontSize: 26,
											        color: Colors.black
										        ),
									          child: Center(child: Text(e,)),
									        )
									      );
								      }).toList(),
								      selectedItemBuilder: (context){
								        return levels.map((e){
								          return Center(
								            child: Text(e,
												      style: TextStyle(
													      fontSize: 26,
													      color: Colors.white,
												      ),
										        ),
								          );
									      }).toList();
								      },
								      onChanged: (newValue){
								        setState(() {
										      level = newValue;
										      print(level);
								        });
								      },
						          icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 40,),
							        ),
							      ),
			          ],
			        ),
				      Row(
					      mainAxisSize: MainAxisSize.min,
					      children: <Widget>[
						      Text("自带图片：",
							      style: TextStyle(
									      fontSize: 28,
									      color: Colors.white
							      ),
						      ),
						      DropdownButtonHideUnderline(
							      child: DropdownButton(
								      value: title,
								      items: titles.map((e){
									      return DropdownMenuItem(
											      value: titles.indexOf(e),
											      child: DefaultTextStyle(
												      textAlign: TextAlign.center,
												      style: TextStyle(
														      fontSize: 28,
														      color: Colors.black
												      ),
												      child: Center(child: Text(e,)),
											      )
									      );
								      }).toList(),
								      selectedItemBuilder: (context){
									      return titles.map((e){
										      return Center(
											      child: Text(e,
												      style: TextStyle(
													      fontSize: 28,
													      color: Colors.white,
												      ),
											      ),
										      );
									      }).toList();
								      },
								      onChanged: (newValue){
									      setState(() {
										      title = newValue;
									      });
								      },
								      icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 40,),
							      ),
						      ),
					      ],
				      ),
			      ],
			    ),
			    OutlineButton(
				    borderSide: BorderSide(color: Colors.white),
				    onPressed: ()async{
				    	rank.getRank().then((value){
								Navigator.of(context).pushNamed('/dialog');
							});
				    },
				    child: Text("排行榜", style: TextStyle(color: Colors.white),),
			    ),
			    OutlineButton(
				    borderSide: BorderSide(color: Colors.white),
				    onPressed: ()async{
				    	Audio.instance.pause();
							await ImagePicker.pickImage(source: ImageSource.gallery).then((value){
								if(value != null){
									setState(() {
										imagePath = value.path;
									});
								}
								Audio.instance.resume();
							});
				    },
				    child: Text("自选图形", style: TextStyle(color: Colors.white),),
			    ),
					OutlineButton(
						borderSide: BorderSide(color: Colors.white),
						onPressed: (){
							if(!isLogin){
								Navigator.of(context).pushNamed('/login');
							}
							else{
								Fluttertoast.showToast(
										msg: "你已登录",
										fontSize: 20,
										gravity: ToastGravity.CENTER,
										textColor: Colors.black,
										backgroundColor: Colors.white
								);
							}
						},
						child: Text("登录", style: TextStyle(color: Colors.white),),
					),
					OutlineButton(
						borderSide: BorderSide(color: Colors.white),
						onPressed: (){
							setState(() {
								isLogin = true;
								userData.username = "游客";
							});
						},
						child: Text("试玩(更改登录状态)$isLogin", style: TextStyle(color: Colors.white),),
					),
			    Container(
				    height: 50,
			      child: Text(
				    imagePath ?? "",
				    textAlign: TextAlign.center,
				    style: TextStyle(color: Colors.purpleAccent),
			      ),
			    ),
			    Padding(
			      padding: const EdgeInsets.only(top: 0.0),
			      child: OutlineButton(
				      borderSide: BorderSide(color: Colors.blue),
					    onPressed: () async{
				      	if(isLogin){
									Audio.instance.loop(AudioUrl.game);
									Navigator.of(context).pushNamed("/game", arguments: {
										"index": title,
										"level": level,
										"path": imagePath,
									}).then((value){
										//	    print(value);
										Audio.instance.loop(AudioUrl.home);
										setState(() {
											imagePath = value;
										});
									});
								}
				      	else{
									Fluttertoast.showToast(
											msg: "你尚未登录",
										fontSize: 20,
										gravity: ToastGravity.CENTER,
										textColor: Colors.black,
											backgroundColor: Colors.white
									);
								}
					    },
					    child: Text("开始游戏",
					      style: TextStyle(
						      color: Colors.blue,
						      fontSize: 20
					      ),
					    ),
			      ),
			    ),
		    ],
	    ),
      ),
    );
  }

  @override
  void dispose() {
		Audio.instance.dispose();
		//移除监听生命周期
		WidgetsBinding.instance.removeObserver(this);
		DatabaseHelper.instance.close();
    super.dispose();
  }

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {
		//监听生命周期
		if(state == AppLifecycleState.paused){
			Audio.instance.pause();
		}else if(state == AppLifecycleState.resumed){
			Audio.instance.resume();
		}
	}

}