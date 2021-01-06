import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final Color white  = HexColor("#ffffff");
final Color homeColor = HexColor("#fafafa");
final Color lightGrey = HexColor("#A3A3A3");//亮灰色
final Color loginTFColor = HexColor("#f3f3f3");//灰色颜色
Color loginButtonColor = HexColor("#00dc9c");//登录按钮颜色
