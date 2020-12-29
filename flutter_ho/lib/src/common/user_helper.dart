import 'package:flutter_ho/src/bean/bean_user.dart';

class UserHelper {
  // 私有化构造函数
  UserHelper._() {}
  // 创建全局用户单例对象
  static UserHelper getInstance = UserHelper._();
  UserBean _userBean;
  // 是否登录
  bool get isLogin => _userBean != null;
}
