import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/audio/audio.dart';
import 'package:flutter_puzzle/audio/audio_url.dart';
import 'package:flutter_puzzle/dialogs/dialog.dart';
import 'package:flutter_puzzle/models/rank.dart';
import 'package:flutter_puzzle/notifications/my_notification.dart';
import 'package:flutter_puzzle/widgets/puzzle.dart';
import 'package:flutter_puzzle/widgets/my_timer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_puzzle/database/data.dart';
import '../r.dart';

class GameRoute extends StatefulWidget {
  @override
  GameRouteState createState() => new GameRouteState();
}

class GameRouteState extends State<GameRoute> with WidgetsBindingObserver, TickerProviderStateMixin{

  List<String> images;
  int index;
  int level;
  String imagePath;
  List<String> items;
  List<String> levels;
  List<String> titles;
  List difficult;
  int title;
  int status;
  List<int> cr;
  GlobalKey<PuzzleState> puzzleKey;
  GlobalKey<MyTimerState> timerKey;

  TextEditingController _textEditingController;
  bool isFirst;  //是否第一次进入此页面

  @override
  void initState() {
    super.initState();
    images = <String>[R.imagesAJpg, R.imagesBPng, R.imagesCJpg, R.imagesDJpg, R.imagesEJpg];
    items = ["开始", "暂停", "停止", "等级", "图片", "自选图形", "排行榜","一键通关"];
    levels = <String>["初级", "中级", "高级"];
    titles = ["样例1", "样例2", "样例3", "样例4", "样例5"];
    cr = [3, 4, 5];
    status = 0;
    puzzleKey = GlobalKey<PuzzleState>();
    timerKey = GlobalKey<MyTimerState>();
    difficult = ["A","B","C"];

    isFirst = true;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isFirst) {
      isFirst = false;
      index = (ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, dynamic>)["index"];
      level = (ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, dynamic>)["level"];
      imagePath = (ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, dynamic>)["path"];
      //   print(imagePath);
      print("didChangeDependencies");
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    Size size = data.size;
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop(imagePath);
        return false;
      },
      child: NotificationListener<MyNotification>(
        onNotification: (notification){
          status = 0;
          Duration time = timerKey.currentState.pause();
          Future.delayed(Duration(milliseconds: 500)).then((_){
	          showDialog(
			          context: context,
			          builder: (context){
				          return AlertDialog(
					          content: Column(
						          mainAxisSize: MainAxisSize.min,
						          children: <Widget>[
							          Text("游戏结束！"),
							          Container(height: 20,),
							          Text("您的成绩：  ${time.toString().substring(0, 7)}"),
						          ],
					          ),
					          actions: <Widget>[
						          FlatButton(
							          child: Text("提交成绩"),
							          onPressed: () async{
                            Options options = Options(headers: {
                              'type':difficult[level]
                            }
                            );
                            Response response = await Dio().post(
                                'https://www.lvyingzhao.cn/puzzle/time',
                                data: {
                                  'username':userData.username,
                                  'time':getSecond(time.toString()),
                                },
                                options: options
                            );
                            Response response2 = await Dio().post(
                              'https://www.lvyingzhao.cn/puzzle/rank',
                            data: {
                                'username':userData.username,
                              'rank':level+1
                            }
                            );
                            print(response);
                            print(response2);
							            /*if(_textEditingController.text != ""){
							              Rank rank = Rank()
                              ..level = level + 1
                              ..name = _textEditingController.text
                              ..score = time.inMilliseconds
                              ..time = DateTime.now().toString();

							              await DatabaseHelper.instance.insert(rank);
                          }*/

                          Audio.instance.loop(AudioUrl.game);
								          Navigator.of(context).pop();
							          },
						          )
					          ],
				          );
			          }
	          );
          });
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(R.imagesBackgroundJpg),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    PopupMenuButton(
                      itemBuilder: (context){
                        return items.map((e){
                          Widget item;
                          if(e == items[3]){
                            item = ExpansionTile(
                              title: Text(e),
                              children: levels.map((e){
                                return ListTile(
                                  title: Center(child: Text(e)),
                                  enabled: !(level == levels.indexOf(e)),
                                  onTap: (){
                               //     print(e);
                                    Navigator.of(context).pop();
                                    setState(() {
                                      level = levels.indexOf(e);
                                      timerKey.currentState.stop();
                                      if(status != 0){
                                        status = 0;
                                        Audio.instance.loop(AudioUrl.game);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            );
                          }else if(e == items[4]){
                            item = ExpansionTile(
                              title:  Text(e),
                              children: titles.map((e){
                                return ListTile(
                                  title: Center(child: Text(e)),
                                  enabled: !(index == titles.indexOf(e)),
                                  onTap: (){
                               //     print(e);
                                    Navigator.of(context).pop();
                                    setState(() {
                                      imagePath = null;
                                      index = titles.indexOf(e);
                                      timerKey.currentState.stop();
                                      if(status != 0){
                                        status = 0;
                                        Audio.instance.loop(AudioUrl.game);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            );
                          }else{
                            bool enabled = true;
                            if(status == 0){
                              if(e == items[1]){
                                //停止状态，暂停 为 false
                                enabled = false;
                              }else if(e == items[2]){
                                //停止状态，停止 为 false
                                enabled = false;
                              }
                            }else if(status == 1){
                              if(e == items[0]){
                                //开始状态，开始 为 false
                                enabled = false;
                              }
                            }else if(status == 2){
                              if(e == items[1]){
                                //暂停状态，暂停 为 false
                                enabled = false;
                              }
                            }
                            item = ListTile(
                              title: Text(e),
                              enabled: enabled,
                              onTap: (){
                            //    print(e);
                                Navigator.of(context).pop();
                                if(e == items[0]){
                                  if(status == 2){
                                    puzzleKey.currentState.startOnly();
                                    timerKey.currentState.resume();
                                  }else if(status == 0){
                                    puzzleKey.currentState.startWithRandomWidgets();
                                    timerKey.currentState.start();
                                    Audio.instance.loop(AudioUrl.start);
                                  }
                                  status = 1;
                                }else if(e == items[1]){
                                  if(status == 1) {
                                    status = 2;
                                    puzzleKey.currentState.pause();
                                    timerKey.currentState.pause();
                                  }
                                }else if(e == items[2]){
                                  status = 0;
                                  puzzleKey.currentState.stop();
                                  timerKey.currentState.stop();

                                  Audio.instance.loop(AudioUrl.game);
                                }else if(e == items[5]){
                                  Audio.instance.pause();
                                  ImagePicker.pickImage(source: ImageSource.gallery).then((image){
                                    if(image != null){
                                      setState(() {
                                        imagePath = image.path;
                                        status = 0;
                                        timerKey.currentState.stop();
                                        Audio.instance.loop(AudioUrl.game);
                                      });
                                    }else{
                                      Audio.instance.resume();
                                    }
                                  });
                                }else if(e == items[6]){
                                  rank.getRank().then((value){
                                    Navigator.of(context).pushNamed('/dialog');
                                  });
                                }
                                else if(e == items[7]){
                                  setState(() {
                                    status = 0;
                                    print(status);
                                    MyNotification("结束").dispatch(context);
                                  });
                                }
                              },
                            );
                          }
                          return PopupMenuItem(
                              value: e,
                              child: item
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      imagePath == null ?
                      Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                      : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      MyTimer(key: timerKey,),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: imagePath == null ? imageLoader(images[index]) : imageLoader(imagePath, type: "file"),
                  builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot){
                    if(snapshot.hasData){
                      return Container(
                        width: size.width,
                        height: size.width,
                        padding: const EdgeInsets.all(10),
                        child: Puzzle(
                          key: puzzleKey,
                          image: snapshot.data,
                          itemSize: Size((MediaQuery.of(context).size.width -20)/cr[level], (MediaQuery.of(context).size.width-20)/cr[level]),
                          itemX: cr[level],
                          itemY: cr[level],
                          status: status,
                        ),
                      );
                    }else{
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ui.Image> imageLoader(String url, {String type = "asset"}){
    ImageStream stream;
    if(type == "asset"){
      stream = AssetImage(url).resolve(ImageConfiguration());
    }else if(type == "file"){
      stream = FileImage(File(url)).resolve(ImageConfiguration());
    }else{
      return null;
    }
    Completer<ui.Image> completer = Completer();
    ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo image, bool synchronousCall){
      ui.Image _image = image.image;
      completer.complete(_image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //监听生命周期
    if(state == AppLifecycleState.paused){
      Audio.instance.pause();
      if(status == 1) {
        status = 2;
        puzzleKey.currentState.pause();
        timerKey.currentState.pause();
      }
    }else if(state == AppLifecycleState.resumed){
      Audio.instance.resume();
    }
  }
}