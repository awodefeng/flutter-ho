import 'package:flutter/material.dart';

class HomeItemPage extends StatefulWidget {
  final int flag;

  HomeItemPage(this.flag);

  @override
  _HomeItemPageState createState() {
    // TODO: implement createState
    return _HomeItemPageState();
  }
}

class _HomeItemPageState extends State<HomeItemPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text("当前页面${widget.flag}"),
      ),
    );
  }
}
