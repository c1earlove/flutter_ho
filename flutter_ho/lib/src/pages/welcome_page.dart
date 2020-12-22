import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/welcome_time_widget.dart';
import 'package:flutter_ho/src/pages/welcome_video_widget.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // 填充全屏
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 第一层 背景 可以是一个图片 也可以是视频播放
            Positioned.fill(
              child: Hero(
                tag: kHeroWelecomVideoPageTag,
                child: Material(
                  child: WelcomeVideoWidget(),
                  color: Colors.transparent,
                ),
              ),
            ),

            // 第二层 倒计时功能
            Positioned(
              child: WelcomeTimeWidget(),
              right: 20,
              bottom: 66,
            ),
          ],
        ),
      ),
    );
  }
}
