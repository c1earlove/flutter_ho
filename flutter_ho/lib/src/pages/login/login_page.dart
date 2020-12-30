import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/custom_widget/custom_textfield_widget.dart';
import 'package:flutter_ho/src/pages/bubble/bubble_widget.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';
import 'package:flutter_ho/src/utils/log_util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _userNameNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _userNameEditController = TextEditingController();
  TextEditingController _passwordEditController = TextEditingController();
  // 密码是否显示
  bool _isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 第一层 背景
            buildBackground(),
            // 第二层 气泡
            Positioned.fill(
              child: BubbleWidget(),
            ),
            // 第三层 高斯模糊
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            // 第四层 logo动画
            buildHeroAnimation(),
            // 第五层 输入框
            Positioned(
              left: 50,
              right: 50,
              bottom: 70,
              child: Column(
                children: [
                  // 用户名输入框
                  buildUserNameTF(),
                  SizedBox(
                    height: 20,
                  ),

                  // 密码输入框
                  buildPasswordTF(),
                  SizedBox(height: 40),
                  // 登录按钮
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      child: Text(
                        "登录",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // 注册按钮
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      child: Text(
                        "注册",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            // 第六层  关闭按钮
            buildCloseWidget(context)
          ],
        ),
      ),
    );
  }

  CustomTextFieldWidget buildPasswordTF() {
    return CustomTextFieldWidget(
      hintText: "密码",
      submit: (value) {},
      focusNode: _passwordNode,
      prefixIconData: Icons.lock_open_outlined,
      suffixIconData: _isPasswordShow ? Icons.visibility_off : Icons.visibility,
      obscureText: _isPasswordShow,
      controller: _passwordEditController,
      rightIconTap: () {
        setState(() {
          _isPasswordShow = !_isPasswordShow;
        });
      },
    );
  }

  CustomTextFieldWidget buildUserNameTF() {
    return CustomTextFieldWidget(
      hintText: "用户名",
      focusNode: _userNameNode,
      prefixIconData: Icons.person,
      controller: _userNameEditController,
      submit: (value) {
        kLog("输入完成 -- $value");
      },
      onChanged: (value) {
        kLog("正在输入 == $value");
      },
    );
  }

  /// 第六层  关闭按钮
  Positioned buildCloseWidget(BuildContext context) {
    return Positioned(
      child: CloseButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      top: 64,
      left: 20,
    );
  }

  Positioned buildHeroAnimation() {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: kHeroLoginPageTag,
            child: Material(
              color: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/login.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "欢迎登录",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent.withOpacity(0.3),
              Colors.blue.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
