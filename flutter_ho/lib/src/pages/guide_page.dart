import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home_page.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';
import 'package:flutter_ho/src/utils/sp_utils.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // 第一层 引导页
        Positioned.fill(
          child: buildPageView(height, width),
        ),
        // 第二层 原点指示器
        buildScrollDot(),
        // 第三层 去首页按钮
        Positioned(
          left: 0,
          right: 0,
          height: 44,
          bottom: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(microseconds: 800),
                height: _currentIndex == 3 ? 44 : 0,
                width: _currentIndex == 3 ? 180 : 0,
                child: ElevatedButton(
                  onPressed: () {
                    SPUtil.save(kIsFirstStartApp, true);
                    NavigatorUtils.pushPageByFade(
                      context: context,
                      targetPage: HomePage(),
                      isReplace: true,
                    );
                  },
                  child: Text("去首页"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Positioned buildScrollDot() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 66,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildIndefot(_currentIndex == 0),
          buildIndefot(_currentIndex == 1),
          buildIndefot(_currentIndex == 2),
          buildIndefot(_currentIndex == 3),
        ],
      ),
    );
  }

  Widget buildIndefot(bool isSelect) {
    return AnimatedContainer(
      height: 10,
      margin: EdgeInsets.only(left: 16),
      width: isSelect ? 40 : 20,
      duration: Duration(microseconds: 800),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  PageView buildPageView(double height, double width) {
    return PageView(
      onPageChanged: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      children: [
        Image.asset(
          "assets/images/sp01.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        Image.asset(
          "assets/images/sp02.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        Image.asset(
          "assets/images/sp03.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        Image.asset(
          "assets/images/sp05.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
