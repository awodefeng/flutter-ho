import 'package:flutter/material.dart';
import 'package:mobile_lander/src/bean/User.dart';
import 'package:mobile_lander/src/utils/spUtils.dart';

class UserHelper {
  //私有化构造函数
  UserHelper._() {}

  //创建全局单例
  static UserHelper getInstance = UserHelper._();

  User? _user;

  //是否登录
  bool get isLogin => _user != null;

  set user(User user) {
    _user = _user;
    SPUtils.saveObject("user", _user);
  }

  void init() {
    Map<String, dynamic> map = SPUtils.getObject("user");
    if (map != null) {
      _user = User.formMap(map);
    }
  }

  void clear() {
    _user = null;
    SPUtils.remove("user");
  }
}
