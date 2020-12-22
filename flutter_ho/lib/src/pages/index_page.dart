import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ho/src/custom_widget/permisson_request_widget.dart';
import 'package:flutter_ho/src/custom_widget/protocol_model.dart';
import 'package:flutter_ho/src/pages/welcome_page.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';

import 'package:flutter_ho/src/utils/log_util.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';
import 'package:flutter_ho/src/utils/sp_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with ProtocolModel {
  List<String> _list = [
    "为您更好的体验应用，所以需要获取您的手机文件存储权限，以保存您的一些偏好设置",
    "您已拒绝权限，所以无法保存您的额一些偏好设置，将无法使用APP",
    "您已拒绝权限，请在设置中心同意APP的权限请求",
    "其他错误",
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initPermissionData();
    });
  }

  /// 初始化工具类
  void initDataNext() async {
    if (Platform.isIOS) {
      Directory dir = await getLibraryDirectory();
      kLog("沙盒路径 = ${dir.path}");
    }

    // 初始化工具类
    await SPUtil.init();
    // 读取标识
    bool isAgrement = await SPUtil.getBool(kIsProtocolArgement);
    if (isAgrement == null || isAgrement == false) {
      // 隐私协议
      isAgrement = await showProtocolFunction(context);
    }

    if (isAgrement) {
      kLog("同意");
      // 记录标识
      SPUtil.save(kIsProtocolArgement, true);
      next();
    } else {
      kLog("不同意");
      SystemChannels.platform.invokeMethod("SystemNavigator.pop");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动"),
      ),
      body: Center(
        child: Image.asset("assets/images/EIBP-iOS.png"),
      ),
    );
  }

  void next() {
    //引导页面
    // 倒计时页面
    NavigatorUtils.pushPageByFade(
      context: context,
      targetPage: WelcomePage(),
      isReplace: true,
    );
  }

  void initPermissionData() async {
    NavigatorUtils.pushPageByFade(
      context: context,
      targetPage: PermissionRequsetWidget(
        isCloseApp: true,
        permission: Permission.camera,
        permissonList: _list,
      ),
      dismissCallBack: (value) {
        kLog("权限申请结果 $value");
        initDataNext();
      },
    );
  }
}
