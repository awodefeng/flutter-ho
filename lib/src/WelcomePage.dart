import 'package:flutter/material.dart';
import 'package:mobile_lander/src/WelcomeTimeWidget.dart';

import 'WelcomeVideoWidget.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() {
    // TODO: implement createState
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          //帧布局
          //第一层用图片或者视频
          Positioned(child: WelcomeVideoWidget()),
          //第二层倒计时功能
          //屏幕的右下角对齐
          Positioned(
            child: WelcomeTimeWidget(),
            right: 20,
            bottom: 66,
          )
        ],
      ),
    ));
  }
}
