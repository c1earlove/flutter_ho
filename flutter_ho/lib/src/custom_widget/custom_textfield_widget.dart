import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  /// 占位提示文本
  final String hintText;

  /// 输入框前置图标
  final IconData prefixIconData;

  /// 输入框后置图标
  final IconData suffixIconData;

  /// 是否隐藏文本
  final bool obscureText;

  /// 输入实时回调
  final Function(String value) onChanged;

  ///
  final TextEditingController controller;

  ///
  final FocusNode focusNode;

  /// 提交
  final Function(String value) submit;

  /// 右侧小图标点击事件
  final Function() rightIconTap;

  /// 键盘类型
  final TextInputType keyboardType;

  const CustomTextFieldWidget({
    Key key,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.submit,
    this.rightIconTap,
    this.keyboardType = TextInputType.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //构建输入框
    return TextField(
      focusNode: focusNode,
      controller: controller,
      //实时输入回调
      onChanged: onChanged,
      onSubmitted: submit,
      keyboardType: keyboardType,
      //是否隐藏文本
      obscureText: obscureText,
      //隐藏文本小圆点的颜色
      cursorColor: Theme.of(context).accentColor,
      //文本样式
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 14.0,
      ),
      //输入框的边框
      decoration: InputDecoration(
        //提示文本
        labelText: hintText,
        //提示文本的样式
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        //可编辑时的提示文本的颜色
        focusColor: Theme.of(context).accentColor,
        //填充
        filled: true,
        //可编辑时 无边框样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),

        //获取输入焦点时的边框样式
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),

        //文本前置的图标
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Theme.of(context).accentColor,
        ),
        //文本后置的图标
        suffixIcon: GestureDetector(
          onTap: rightIconTap,
          child: Icon(
            suffixIconData,
            size: 18,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
