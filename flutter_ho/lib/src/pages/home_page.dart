import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home_page/home_item_page.dart';
import 'package:flutter_ho/src/pages/user/mine_main_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 默认选中第一个
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 一般使用pageView 结合bottomNavigationBar
        child: PageView(
          controller: _pageController,
          // 不可左右滑动
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeItemPage(flag: 1),
            HomeItemPage(flag: 2),
            Text("这是页面3"),
            MineMainPage(),
            // HomeItemPage(flag: 3),
            // HomeItemPage(flag: 4),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 点击回调
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _pageController.jumpToPage(value);
          });
        },
        //当前选中的item 默认0
        currentIndex: _currentIndex,
        // 显示图标和文本
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.five_g),
            label: "发现",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "消息",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
