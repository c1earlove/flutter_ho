import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/color_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showToast({String message = "加载中..."}) {
    // 根据消息长度决定自动消失时间
    double multiplier = 0.5;
    double flag = message.length * 0.06 + 0.5;
    // 计算显示时间
    int timeInsecForIOS = (multiplier * flag).round();
    // 如果已显示 先取消已有的
    Fluttertoast.cancel();
    // 显示toast
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black54,
      // 居中展示
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: timeInsecForIOS,
      textColor: Colors.white,
    );
  }
}
