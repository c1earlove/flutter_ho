import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/constant_string.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Hero(
              tag: kHeroLoginPageTag,
              child: Material(
                color: Colors.transparent,
                child: Image.asset(
                  "assets/images/login.png",
                  width: 40,
                  height: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
