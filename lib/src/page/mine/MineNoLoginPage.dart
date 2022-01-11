import 'package:flutter/material.dart';
import 'package:mobile_lander/src/page/login/LoginPage.dart';
import 'package:mobile_lander/src/utils/navigator_utils.dart';

class MineNoLoginPage extends StatefulWidget {
  @override
  _MineNoLoginPageState createState() {
    return _MineNoLoginPageState();
  }
}

const String _TAG = "_TestPageState";

class _MineNoLoginPageState extends State<MineNoLoginPage> {
  bool isDown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              //按下
              setState(() {
                isDown = true;
              });
            },
            onTapCancel: () {
              //移除
              setState(() {
                isDown = false;
              });
            },
            onTap: () {
              //跳转登陆界面
              setState(() {
                isDown = false;
              });
              NavigatorUtils.pushPageByFade(
                  startMills: 800,
                  context: context,
                  targetPage: LoginPage(),
                  dismissCallBack: (value) {
                    if (value != null) {
                      setState(() {});
                    }
                  });
            },
            child: buildHero(),
          )
        ],
      ),
    );
  }

  Hero buildHero() {
    return Hero(
      tag: "logo",
      child: Material(
        color: Colors.transparent,
        child: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: 66,
      height: 66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.redAccent,
        //按下的阴影
        boxShadow: isDown
            ? [
                const BoxShadow(
                    offset: Offset(3, 4), color: Colors.black, blurRadius: 13)
              ]
            : null,
      ),
      child: const Text(
        "登录",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
