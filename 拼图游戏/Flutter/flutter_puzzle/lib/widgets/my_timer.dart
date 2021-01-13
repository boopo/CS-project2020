import 'dart:async';

import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {

  MyTimer({
    Key key,
    this.duration = const Duration(),
  }): super(key: key);

  final Duration duration;

  @override
  MyTimerState createState() => new MyTimerState();
}

class MyTimerState extends State<MyTimer> {

  Duration time;
  Timer timer;
  Stopwatch watch;

  @override
  void initState() {
    super.initState();
    time = widget.duration;
    watch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(time.toString().substring(0,7)),
      ),
    );
  }



  start(){
    watch.reset();
    watch.start();
    timer = Timer.periodic(Duration(milliseconds: 100), (timer){
      setState(() {
        time = watch.elapsed;
      });
    });
  }

  Duration pause(){
    if(watch.isRunning) {
      watch.stop();
  //    print(watch.elapsed);
      if(timer != null){
        timer.cancel();
      }
    }
    return watch.elapsed;
  }

  resume(){
    watch.start();
    timer = Timer.periodic(Duration(milliseconds: 100), (
        timer){
      setState(() {
        time = watch.elapsed;
      });
    });
  }

  stop(){
    watch.reset();
 //   print(watch.elapsed);
    if(timer != null){
      timer.cancel();
    }
    setState(() {
      time = Duration();
    });
  }

  @override
  void dispose() {
    if(timer != null){
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }
}


String getSecond(String time){
  List<String> timeList;
  String second;
  timeList = time.toString().substring(0,7).split(':');
  second = (int.parse(timeList[0])*3600 +
      int.parse(timeList[1])*60 +
      int.parse(timeList[2])).toString();
  return second;
}