import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_lander/src/page/common/protocol_model.dart';
import 'package:mobile_lander/src/utils/log_utils.dart';
import 'package:mobile_lander/src/utils/navigator_utils.dart';
import 'package:mobile_lander/src/utils/spUtils.dart';
import 'package:permission_handler/permission_handler.dart';

import 'FirstGuildPage.dart';
import 'WelcomePage.dart';
import 'page/common/permisson_request_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

const String _TAG = "_IndexPageState";

class _IndexPageState extends State with ProtocolModel {
  final List<String> _list = [
    "为您更好的体验应用，所以需要获取您手机文件的存储权限，以保存您的一些偏好设置",
    "您已拒绝权限，所以无法保存您的一些偏好设置，将无法使用APP",
    "您已拒绝权限，请在设置中心同意APP的权限申请",
    "其他错误"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动"),
      ),
      body: Text("这里是body"),
    );
  }

  void initData() {
    NavigatorUtils.pushPageByFade(
        context: context,
        targetPage: PermissonRequestWidget(
          permission: Permission.storage,
          permissionList: _list,
          isCloseApps: true,
        ),
        dismissCallBack: (value) {
          LogUtils.e(_TAG, "权限申请结果$value");

          initDataNext();
        });
  }

  //初始化工具类和一些第三方或者一些其他的东西
  void initDataNext() async {
    await SPUtils.init();
    bool? isAgreement = await SPUtils.getBool("isAgreement");
    if (isAgreement == null || !isAgreement) {
      isAgreement = await showProtocolFunction(context);
    }
    if (isAgreement) {
      SPUtils.save("isAgreement", true);
      next();
    } else {
      closeApp();
    }
  }

  void closeApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  void next() async{
    //判断是否第一次安装应用
    bool? isFirstInstall = await SPUtils.getBool("isFirstInstall");
    if(isFirstInstall==null){
      //第一次安装进入
      // 引导页面
      NavigatorUtils.pushPageByFade(
          context: context, targetPage: FirstGuildPage(), isReplace: true);
    }else {
      NavigatorUtils.pushPageByFade(
          context: context, targetPage: WelcomePage(), isReplace: true);
    }
  }
}
