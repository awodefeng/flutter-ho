import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_lander/src/page/common/UserHelper.dart';
import 'package:mobile_lander/src/page/common/controller.dart';
import 'package:mobile_lander/src/page/mine/MineLoginPage.dart';
import 'package:mobile_lander/src/page/mine/MineNoLoginPage.dart';

class MineMainPage extends StatefulWidget {
  @override
  _MineMainPageState createState() {
    return _MineMainPageState();
  }
}

const String _TAG = "_TestPageState";

class _MineMainPageState extends State<MineMainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Stream 监听
    //用来远程通知当前页面刷新 目前在登录页面有使用
    loginStreamController.stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: buildMainBody(),
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.grey));
  }

  buildMainBody() {
    if (UserHelper.getInstance.isLogin) {
      //返回登录的布局
      return MineLoginPage();
    } else {
      //返回未登录的布局
      return MineNoLoginPage();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginStreamController.close();
    super.dispose();
  }
}
