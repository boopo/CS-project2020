import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/notifications/my_notification.dart';

import 'crop.dart';

class Puzzle extends StatefulWidget {

  Puzzle({
    Key key,
    this.image,
    this.itemSize,
    this.itemX,
    this.itemY,
    this.status = 0,
  }): super(key: key);

  final ui.Image image;
  final Size itemSize;
  final int itemX;
  final int itemY;
  //状态：0，停止；1，开始；2，暂停
  final int status;

  @override
  PuzzleState createState() => new PuzzleState();
}

class PuzzleState extends State<Puzzle> {

  List<ImageItem> widgets;
  List<Offset> offsets;
  Color selectColor;

  int x;
  int y;
  int index;
  Offset startPosition;
  Offset endOPosition;

  Offset deltOffset;

  ImageItem tempItem;
  GlobalKey<ImageItemState> tempKey;
  OverlayEntry _overlayEntry;

  int status;

  bool isH; //是否水平拖动

  @override
  void initState() {
    super.initState();
    status = widget.status;
    widgets = [];
    offsets = [];
    selectColor = Colors.deepOrangeAccent;
    cropImage(widget.image, widget.itemSize, widget.itemX, widget.itemY);
  }

  @override
  void didUpdateWidget(Puzzle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.image != widget.image || oldWidget.itemX != widget.itemX || oldWidget.itemY != widget.itemY){
      cropImage(widget.image, widget.itemSize, widget.itemX, widget.itemY);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details){
        if(status == 1) {
          startPosition = details.localPosition;
          x = startPosition.dx ~/ widget.itemSize.width;
          y = startPosition.dy ~/ widget.itemSize.height;
          index = y * widget.itemY + x;
          tempItem = widgets[index];

          widgets.removeAt(index);

          tempKey = tempItem.key as GlobalKey<ImageItemState>;

          selectColor = Colors.yellowAccent;
          tempKey.currentState.updateColor(selectColor);

          deltOffset = details.position - details.localPosition;

          _overlayEntry = OverlayEntry(builder: (context) {
            return tempItem;
          });
          Overlay.of(context).insert(_overlayEntry);
          tempKey.currentState.offset =
              tempKey.currentState.offset + deltOffset;
          setState(() {

          });
        }
      },
      onPointerMove: (details){
        if(status == 1) {
          if(isH == null){
            if(details.delta.dx.abs() >= details.delta.dy.abs()){
              isH = true;
            }else{
              isH = false;
            }
          }
          Offset delta;
          if(isH){
            delta = Offset(details.localPosition.dx - startPosition.dx, 0);
            if(x == 0){
              if(delta.dx < 0){
                endOPosition = offsets[index] + deltOffset;
              }else if(delta.dx > widget.itemSize.width){
                endOPosition = offsets[index+1] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }else if(x == widget.itemX -1){
              if(delta.dx < -widget.itemSize.width){
                endOPosition = offsets[index-1] + deltOffset;
              }else if(delta.dx > 0){
                endOPosition = offsets[index] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }else if(x > 0 && x < widget.itemX){
              if(delta.dx < -widget.itemSize.width){
                endOPosition = offsets[index-1] + deltOffset;
              }else if(delta.dx > widget.itemSize.width){
                endOPosition = offsets[index+1] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }
          }else{
            delta = Offset(0, details.localPosition.dy - startPosition.dy);
            if(y == 0){
              if(delta.dy < 0){
                endOPosition = offsets[index] + deltOffset;
              }else if(delta.dy > widget.itemSize.height){
                endOPosition = offsets[index + widget.itemX] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }else if(y == widget.itemY -1){
              if(delta.dy < -widget.itemSize.height){
                endOPosition = offsets[index - widget.itemX] + deltOffset;
              }else if(delta.dy > 0){
                endOPosition = offsets[index] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }else if(y > 0 && y < widget.itemY){
              if(delta.dy < -widget.itemSize.height){
                endOPosition = offsets[index - widget.itemX] + deltOffset;
              }else if(delta.dy > widget.itemSize.height){
                endOPosition = offsets[index + widget.itemX] + deltOffset;
              }else{
                endOPosition = offsets[index] + delta + deltOffset;
              }
            }
          }
          tempKey.currentState.updateOffset(endOPosition);
        }
      },
      onPointerUp: (details){
        if(status ==1) {
          int endX = ((endOPosition.dx-deltOffset.dx) / widget.itemSize.width).round();
          int endY = ((endOPosition.dy-deltOffset.dy) / widget.itemSize.height).round();

          selectColor = Colors.deepOrangeAccent;
          tempKey.currentState.updateColor(selectColor);

          int next;
          if (endX - x == 0 && endY - y == 0) {
            tempKey.currentState.startAnimation(
                Duration(milliseconds: 200), offsets[index] + deltOffset);
            _overlayEntry.remove();

            tempKey.currentState.updateOffset(offsets[index]);
            tempKey.currentState.updateDuration(Duration());
            widgets.insert(index, tempItem);
            setState(() {

            });
          } else {
            if ((endX - x).abs() > (endY - y).abs()) {
              if (endX - x > 0) {
                next = y * widget.itemY + (x + 1);
              } else {
                next = y * widget.itemY + (x - 1);
              }
            } else {
              if (endY - y > 0) {
                next = (y + 1) * widget.itemY + x;
              } else {
                next = (y - 1) * widget.itemY + x;
              }
            }

            if (next < index) {
              tempKey.currentState.startAnimation(
                  Duration(milliseconds: 200), offsets[next]);
              (widgets[next].key as GlobalKey<ImageItemState>).currentState
                  .startAnimation(Duration(milliseconds: 200), offsets[index]);
              _overlayEntry.remove();

              Widget n = widgets[next];
              widgets.insert(index, n);
              widgets.removeAt(next);

              tempKey.currentState.updateOffset(offsets[next]);
              tempKey.currentState.updateDuration(Duration());
              widgets.insert(next, tempItem);
              setState(() {

              });
            } else {
              tempKey.currentState.startAnimation(
                  Duration(milliseconds: 200), offsets[next]);
              (widgets[next - 1].key as GlobalKey<ImageItemState>).currentState
                  .startAnimation(Duration(milliseconds: 200), offsets[index]);

              _overlayEntry.remove();

              Widget n = widgets[next - 1];
              widgets.insert(index, n);
              widgets.removeAt(next);

              tempKey.currentState.updateOffset(offsets[next]);
              tempKey.currentState.updateDuration(Duration());
              widgets.insert(next, tempItem);
              setState(() {

              });
            }
          }

          isH = null;
          deltOffset = null;
          tempItem = null;
          tempKey = null;
          check();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepOrangeAccent
          )
        ),
        child: Stack(
          children: widgets,
        ),
      ),
    );
  }

  cropImage(ui.Image image, Size size, int itemX, int itemY){
    double itemWidth = image.width/itemX;
    double itemHeight = image.height/itemY;

    widgets.clear();
    offsets.clear();
    for(int i = 0; i < itemY; i++) {
      for (int j = 0; j < itemX; j++) {
        GlobalKey<ImageItemState> key = GlobalKey<ImageItemState>();
        Rect rawRect = Rect.fromLTWH(j*itemWidth, i*itemHeight, itemWidth, itemHeight);
        Rect targetRect = Rect.fromLTWH(0, 0, size.width, size.width);
        offsets.add(Offset(j*size.width, i*size.width));
        ImageItem item = ImageItem(
          key: key,
          index: i*itemY + j,
          image: image,
          rowRect: rawRect,
          targetRect: targetRect,
          offset: offsets[i*itemY + j],
          color: selectColor,
        );
        widgets.add(item);
      }
    }
  }

  startWithRandomWidgets(){
    widgets.shuffle();
    for(int i = 0; i < offsets.length; i++){
      (widgets[i].key as GlobalKey<ImageItemState>).currentState.updateOffset(offsets[i]);
    }
    setState(() {
      status = 1;
    });
  }

  startOnly(){
    setState(() {
      status = 1;
    });
  }

  stop(){
    setState(() {
      status = 0;
    });
  }

  pause(){
    setState(() {
      status = 2;
    });
  }

  check(){
    for(int i = 0; i < widgets.length; i++){
      if(widgets[i].index != i){
        return;
      }
    }
    status = 0;
    MyNotification("结束").dispatch(context);
 //   print("游戏结束");
  }
}

// ignore: must_be_immutable
class ImageItem extends StatefulWidget {

  ImageItem({
    Key key,
    this.index,
    this.image,
    this.rowRect,
    this.targetRect,
    this.offset,
    this.color,
  }): super(key: key);

  final int index;
  final ui.Image image;
  final Rect rowRect;
  final Rect targetRect;
  Offset offset;
  final Color color;

  @override
  ImageItemState createState() => new ImageItemState();
}

class ImageItemState extends State<ImageItem> {

  Color color;
  Offset offset;
  Duration duration;

  @override
  void initState() {
    super.initState();
    color = widget.color;
    offset = widget.offset;
    duration = Duration();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      curve: Curves.easeIn,
      top: offset.dy,
      left: offset.dx,
      child: Container(
        width: widget.targetRect.right - widget.targetRect.left,
        height: widget.targetRect.bottom - widget.targetRect.top,
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          )
        ),
        child: Crop(widget.image, widget.rowRect, widget.targetRect),
      ),
    );
  }

  updateColor(Color color){
    this.color = color;
    duration = Duration();
    setState(() {

    });
  }

  updateDuration(Duration duration){
    this.duration = duration;
    setState(() {

    });
  }

  updateOffset(Offset offset){
    this.offset = offset;
    setState(() {

    });
  }

  startAnimation(Duration duration, Offset offset){
    this.offset = offset;
    this.duration = duration;
    setState(() {

    });
  }
}