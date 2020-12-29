import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/login/login_page.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

class MineNoLoginPage extends StatefulWidget {
  MineNoLoginPage({Key key}) : super(key: key);

  @override
  _MineNoLoginPageState createState() => _MineNoLoginPageState();
}

class _MineNoLoginPageState extends State<MineNoLoginPage> {
  bool _isDown = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFCDDEEC),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // 跳转登录页面
              NavigatorUtils.pushPageByFade(
                context: context,
                targetPage: LoginPage(),
                startMills: 800,
              );
              // 更新状态
              setState(() {
                _isDown = false;
              });
            },
            onTapDown: (TapDownDetails details) {
              // 手指按下的时候
              setState(() {
                _isDown = true;
              });
            },
            onTapCancel: () {
              // 还原
              setState(() {
                _isDown = false;
              });
            },
            child: buildHero(),
          ),
        ],
      ),
    );
  }

  // 构建hero动画
  Hero buildHero() {
    return Hero(
      tag: kHeroLoginPageTag,
      child: Material(
        // 使用hero动画必须使用material嵌套
        // 透明色
        color: Colors.transparent,
        child: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: _isDown
            ? [
                BoxShadow(
                  offset: Offset(3, 4),
                  color: Colors.black,
                  blurRadius: 12,
                ),
              ]
            : null,
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Text(
        "登录",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
