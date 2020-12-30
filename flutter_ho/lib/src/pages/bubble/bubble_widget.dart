import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/bubble/bubble_bean.dart';
import 'package:flutter_ho/src/pages/bubble/bubble_painter.dart';
import 'package:flutter_ho/src/utils/color_util.dart';

class BubbleWidget extends StatefulWidget {
  @override
  _BubbleWidgetState createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget>
    with SingleTickerProviderStateMixin {
  List<BubbleBean> _list = [];
  // 随机数据
  Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  /// 气泡最大半径
  double maxRadius = 80;

  /// 气泡最大移动速度
  double maxSpeed = 1;

  /// 气泡计算使用的最大弧度
  double maxTheta = 2.0 * pi;

  /// 动画控制器
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 20; i++) {
      BubbleBean particle = BubbleBean();
      particle.color = ColorUtils.getRandonWhightColor(_random);
      particle.postion = Offset(-1, -1);
      particle.speed = _random.nextDouble() * maxSpeed;
      particle.theta = _random.nextDouble() * maxTheta;
      particle.radius = _random.nextDouble() * maxRadius;
      _list.add(particle);
    }

    /// 动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    /// 监听
    _animationController.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 200), () {
      _animationController.repeat();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomMyPainter(
        list: _list,
        random: _random,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
