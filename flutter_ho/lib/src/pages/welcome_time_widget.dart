import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home_page.dart';
import 'package:flutter_ho/src/utils/log_util.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

class WelcomeTimeWidget extends StatefulWidget {
  WelcomeTimeWidget({Key key}) : super(key: key);

  @override
  _WelcomeTimeWidgetState createState() => _WelcomeTimeWidgetState();
}

class _WelcomeTimeWidgetState extends State<WelcomeTimeWidget> {
  int currentTime = 5;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // 创建一个计时器 间隔1s执行
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTime == 0) {
        // 停止计时 去首页
        _timer.cancel();
        goHome();
        return;
      }
      // 每隔一秒执行一次
      currentTime--;
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: buildContainer(),
      onTap: () {
        goHome();
      },
    );
  }

  Container buildContainer() {
    return Container(
      width: 100,
      height: 33,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      // color: Colors.blue,
      child: Text(
        "${currentTime}s",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    );
  }

  void goHome() {
    kLog("去首页");
    NavigatorUtils.pushPageByFade(
      context: context,
      targetPage: HomePage(),
      isReplace: true,
      dismissCallBack: (value) {
        kLog("穿的值$value");
      },
    );
  }
}
