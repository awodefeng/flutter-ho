import 'package:flutter/material.dart';
import 'package:mobile_lander/src/homePage.dart';
import 'package:mobile_lander/src/utils/navigator_utils.dart';
import 'package:mobile_lander/src/utils/spUtils.dart';

class FirstGuildPage extends StatefulWidget {
  @override
  _FirstGuildPageState createState() {
    return _FirstGuildPageState();
  }
}

const String _TAG = "_FirstGuildPageState";

class _FirstGuildPageState extends State<FirstGuildPage> {
  int _currIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
          //第一层的图片显示
          buildBackground(width, height),
      //第二层的圆点
      buildIndefotPositioned(),
      //第三层去主页的按钮
      buildGoHome()
      ],
    ),);
  }

  Positioned buildGoHome() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: _currIndex == 3?44:0,
            width: _currIndex == 3?180:0,
            child: ElevatedButton(
              child: Text("去首页"), onPressed: () {
                SPUtils.save("isFirstInstall", true);
                NavigatorUtils.pushPageByFade(context: context, targetPage: HomePage(),isReplace: true);
            },),)
        ],
      ),
    );
  }

  Positioned buildIndefotPositioned() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildIndefot(_currIndex == 0),
          buildIndefot(_currIndex == 1),
          buildIndefot(_currIndex == 2),
          buildIndefot(_currIndex == 3),
        ],
      ),
    );
  }

  Positioned buildBackground(double width, double height) {
    return Positioned(
      child: PageView(
        onPageChanged: (value) {
          setState(() {
            _currIndex = value;
          });
        },
        children: [
          Image.asset(
            "assets/image/sp01.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/image/sp02.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/image/sp03.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/image/sp04.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget buildIndefot(bool isSelect) {
    return AnimatedContainer(
      height: 10,
      width: isSelect ? 30 : 10,
      margin: const EdgeInsets.only(left: 16),
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
