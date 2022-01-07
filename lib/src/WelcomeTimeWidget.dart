import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_lander/src/homePage.dart';
import 'package:mobile_lander/src/utils/navigator_utils.dart';

//倒计时功能
class WelcomeTimeWidget extends StatefulWidget {
  @override
  _WelcomeTimeWidgetState createState() {
    // TODO: implement createState
    return _WelcomeTimeWidgetState();
  }
}

class _WelcomeTimeWidgetState extends State<WelcomeTimeWidget> {
  int currTime = 5;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //创建一个计时器 间隔1秒执行
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currTime == 0) {
        //停止计时器 去首页
        _timer.cancel();
        goHome();
        return;
      }

      //每隔1秒执行一次
      currTime--;
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          goHome();
        },
        child: buildContainer());
  }

  Container buildContainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      alignment: Alignment.center,
      child: Text(
        "${currTime}s",
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.redAccent),
      ),
      width: 100,
      height: 33,
    );
  }

  void goHome() {
    NavigatorUtils.pushPageByFade(context: context, targetPage: HomePage(),isReplace: true);
  }
}
