import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_lander/src/page/common/common_webview.dart';
import 'package:mobile_lander/src/utils/navigator_utils.dart';

class ProtocolModel {
   late TapGestureRecognizer _registProtocolRecognizer;
   late TapGestureRecognizer _privacyProtocolRecognizer;

  Future<bool> showProtocolFunction(BuildContext context) async {
    //注册协议的手势
    _registProtocolRecognizer = new TapGestureRecognizer();
    //注册隐私的手势
    _privacyProtocolRecognizer = new TapGestureRecognizer();
    //苹果风格弹框
    bool isShow = await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog(context);
        });

    //销毁协议的手势
    _registProtocolRecognizer.dispose();
    //销毁隐私的手势
    _privacyProtocolRecognizer.dispose();
    return Future.value(isShow);
  }

  CupertinoAlertDialog cupertinoAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("温馨提示"),
      content: Container(
        padding: EdgeInsets.all(12),
        height: 240,
        //可滑动布局
        child: SingleChildScrollView(
          child: buildContext(context),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("不同意"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: Text("同意"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }

  String userPrivateProtocol =
      "软件产品安装协议 欢迎使用安超云软件有限公司（“安超”）出品的【安超桌面云】软件（“本软件”），安超软件受著作权法及国际条约条款和其它知识产权法及条约的保护。请务必仔细阅读和理解本软件著作权法及国际条约条款和其它知识产权法及条约的保护。请务必仔细阅读和理解本软件著作权法及国际条约条款和其它知识产权法及条约的保护。请务必仔细阅读和理解本软件著作权法及国际条约条款和其它知识产权法及条约的保护。请务必仔细阅读和理解本软件";

  buildContext(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "请您在使用本产品之前仔细阅读",
          style: TextStyle(color: Colors.grey[600]),
          children: [
            TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
                recognizer: _registProtocolRecognizer
                  ..onTap = () {
                    openUserProtocol(context);
                  }),
            TextSpan(text: "与"),
            TextSpan(
                text: "《隐私协议》",
                style: TextStyle(color: Colors.blue),
                recognizer: _privacyProtocolRecognizer
                  ..onTap = () {
                    openPrivacyProtocol(context);
                  }),
            TextSpan(text: userPrivateProtocol)
          ]),
    );
  }

  //查看用户协议
  void openUserProtocol(BuildContext context) {
    NavigatorUtils.pushPage(
        context: context,
        targetPage: CommonWebViewPage(
          pageTitle: "用户协议",
            htmlUrl:
                "https://biglead.blog.csdn.net/article/details/117443371"));
  }

  //查看隐私协议
  void openPrivacyProtocol(BuildContext context) {
    NavigatorUtils.pushPage(
        context: context,
        targetPage: CommonWebViewPage(
            pageTitle: "隐私协议",
            htmlUrl:
                "https://biglead.blog.csdn.net/article/details/117443371"));
  }
}
