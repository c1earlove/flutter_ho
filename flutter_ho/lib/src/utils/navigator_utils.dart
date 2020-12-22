import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'log_util.dart';

class NavigatorUtils {
  // 普通打开页面
  /// [context] 上下文对象
  /// [targetPage] 目标页面
  /// [isReplace] 是否替换当前页面
  static void pushPage({
    @required BuildContext context,
    @required Widget targetPage,
    bool isReplace = false,
    Function(dynamic value) dismissCallBack,
  }) {
    PageRoute pageRoute;
    if (Platform.isAndroid) {
      pageRoute = MaterialPageRoute(builder: (BuildContext context) {
        return targetPage;
      });
    } else {
      pageRoute = CupertinoPageRoute(builder: (BuildContext context) {
        return targetPage;
      });
    }
    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  // 普通打开页面
  /// [context] 上下文对象
  /// [targetPage] 目标页面
  /// [isReplace] 是否替换当前页面
  /// [opaque] 是否以背景透明的方式打开页面

  static void pushPageByFade({
    @required BuildContext context,
    @required Widget targetPage,
    bool isReplace = false,
    bool opaque = false,
    Function(dynamic value) dismissCallBack,
  }) {
    PageRoute pageRoute = PageRouteBuilder(
        opaque: opaque,
        // 构建过度动画
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return targetPage;
        });
    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }
}
