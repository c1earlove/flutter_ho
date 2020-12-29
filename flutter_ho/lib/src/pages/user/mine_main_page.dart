import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_ho/src/common/user_helper.dart';
import 'package:flutter_ho/src/pages/login/mine_login_page.dart';
import 'package:flutter_ho/src/pages/login/mine_no_login_page.dart';

class MineMainPage extends StatefulWidget {
  MineMainPage({Key key}) : super(key: key);

  @override
  _MineMainPageState createState() => _MineMainPageState();
}

class _MineMainPageState extends State<MineMainPage> {
  @override
  Widget build(BuildContext context) {
    //
    return AnnotatedRegion(
      child: buildMianBody(),
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Color(0xFFCDDEEC),
      ),
    );
  }

  buildMianBody() {
    // 判断用户是否已经登录
    if (UserHelper.getInstance.isLogin) {
      // 返回登录后的布局
      return MineLoginPage();
    } else {
      // 返回未登录的布局
      return MineNoLoginPage();
    }
  }
}
