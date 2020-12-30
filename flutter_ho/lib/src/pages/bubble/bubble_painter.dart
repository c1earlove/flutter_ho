import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/bubble/bubble_bean.dart';

class CustomMyPainter extends CustomPainter {
  // 创建画笔
  Paint _paint = Paint();
  // 保存气泡集合
  List<BubbleBean> list;
  // 随机数变量
  Random random;
  // 构造函数
  CustomMyPainter({this.list, this.random});
  // 计算坐标
  Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 每次绘制都重新计算位置
    list.forEach(
      (element) {
        // 计算偏移量
        var velocity = calculateXY(element.speed, element.theta);
        // 新的坐标 微偏移
        var dx = element.postion.dx + velocity.dx;
        var dy = element.postion.dy + velocity.dy;
        // x轴边界计算
        if (element.postion.dx < 0 || element.postion.dx > size.width) {
          // 超出边界
          dx = random.nextDouble() * size.width;
        }
        // y轴边界计算
        if (element.postion.dy < 0 || element.postion.dy > size.height) {
          dy = random.nextDouble() * size.height;
        }
        element.postion = Offset(dx, dy);
      },
    );
    // 循环绘制所有的气泡
    list.forEach((element) {
      // 画笔颜色
      _paint.color = element.color;
      // 绘制圆
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(CustomMyPainter oldDelegate) => true;

  // @override
  // bool shouldRebuildSemantics(CustomMyPainter oldDelegate) => false;
}
