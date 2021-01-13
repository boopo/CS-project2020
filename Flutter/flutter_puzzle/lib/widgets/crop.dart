import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class Crop extends StatefulWidget {

  const Crop(
    this.image,
    this.rawRect,
    this.targetRect,{
    Key key,
  }): super(key: key);

  final ui.Image image;
  final Rect rawRect;
  final Rect targetRect;

  @override
  CropState createState() => new CropState();
}

class CropState extends State<Crop> {

  MyPainter myPainter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: CustomPaint(
          painter: MyPainter(widget.image, widget.rawRect, widget.targetRect),
      ),
    );
  }

}

class MyPainter extends CustomPainter{

  MyPainter(this.image,
    this.rawRect,
    this.targetRect,);

  final ui.Image image;
  final Rect rawRect;
  final Rect targetRect;

  @override
  void paint(ui.Canvas canvas, ui.Size size) async{
    Paint paint = Paint();
    canvas.drawImageRect(image, rawRect, targetRect, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}