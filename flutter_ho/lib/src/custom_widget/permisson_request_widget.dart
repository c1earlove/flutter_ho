import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ho/src/utils/log_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';

class PermissionRequsetWidget extends StatefulWidget {
  /// 权限类型 camera
  final Permission permission;

  /// 提示语
  final List<String> permissonList;

  /// 是否显示关闭应用按钮
  final bool isCloseApp;
  final String leftButtonText;
  PermissionRequsetWidget({
    Key key,
    @required this.permission,
    @required this.permissonList,
    this.isCloseApp = false,
    this.leftButtonText = "再考虑一下",
  }) : super(key: key);

  @override
  _PermissionRequsetWidgetState createState() =>
      _PermissionRequsetWidgetState();
}

class _PermissionRequsetWidgetState extends State<PermissionRequsetWidget>
    with WidgetsBindingObserver {
  // 页面初始化
  @override
  void initState() {
    super.initState();

    checkPermission();
    // 注册观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermission();
    }
  }

  // 注销观察者
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
    );
  }

  // 检查权限
  void checkPermission({PermissionStatus status}) async {
    // 定义权限
    Permission permission = widget.permission;
    // 权限状态
    if (status == null) {
      status = await permission.status;
    }
    if (status.isUndetermined) {
      // 第一次申请权限
      showPermissonAlert(widget.permissonList[0], "同意", permission);
    } else if (status.isDenied) {
      if (Platform.isIOS) {
        showPermissonAlert(widget.permissonList[2], "去设置中心", permission,
            isSetting: true);
        return;
      } else {
        // 用户第一次拒绝申请
        showPermissonAlert(widget.permissonList[1], "重试", permission);
      }
    } else if (status.isPermanentlyDenied) {
      // 用户第二次拒绝申请
      showPermissonAlert(widget.permissonList[2], "去设置中心", permission,
          isSetting: true);
    } else {
      // 允许   关闭页面
      Navigator.of(context).pop(true);
    }
  }

  // 是否去设置中心
  bool _isGoSetting = false;
  void showPermissonAlert(
      String message, String rightString, Permission permission,
      {bool isSetting = false}) {
    showCupertinoDialog(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Text(message),
            ),
            actions: [
              // 左按钮
              CupertinoDialogAction(
                child: Text("${widget.leftButtonText}"),
                onPressed: () {
                  if (widget.isCloseApp) {
                    kLog("关闭应用");
                    closeApp();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              // 右按钮
              CupertinoDialogAction(
                child: Text("$rightString"),
                onPressed: () {
                  // 关闭弹窗
                  Navigator.of(context).pop(true);
                  if (isSetting) {
                    _isGoSetting = true;
                    // 去设置中心
                    openAppSettings();
                  } else {
                    // 申请权限
                    requestPermission(permission);
                  }
                },
              ),
            ],
          );
        });
  }

  void closeApp() {
    exit(0);
    // await SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  void requestPermission(Permission permission) async {
    // 发起权限申请
    PermissionStatus status = await permission.request();
    checkPermission(status: status);
  }
}
