import 'package:flutter/material.dart';
import 'package:mobile_lander/src/page/home/HomeItemPage.dart';
import 'package:mobile_lander/src/page/mine/MineMainPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currIndex = 0;
  final PageController _pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
          controller: _pageController,
          //不可左右滑动
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeItemPage(1),
            HomeItemPage(2),
            HomeItemPage(3),
            MineMainPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //当前选中默认为0
        currentIndex: _currIndex,
        //点击回调
        onTap: (int value) {
          setState(() {
            _currIndex = value;
            _pageController.jumpToPage(value);
          });
        },
        //显示文字
        type: BottomNavigationBarType.fixed,
        //选中颜色
        selectedItemColor: Colors.redAccent,
        //未选中颜色
        unselectedItemColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.five_g), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
