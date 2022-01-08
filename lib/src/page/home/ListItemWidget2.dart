import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_lander/src/page/play/VideoDetailWidget.dart';
import 'package:mobile_lander/src/page/play/VideoDetailWidget2.dart';
import 'package:mobile_lander/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

class ListItemWidget2 extends StatefulWidget {
  final StreamController? streamController;
  final bool isScroll;

  ListItemWidget2({this.isScroll = false, this.streamController});

  @override
  _ListItemWidgetState createState() {
    // TODO: implement createState
    return _ListItemWidgetState();
  }
}

class _ListItemWidgetState extends State<ListItemWidget2> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2),
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Container(
        height: 160,
        child: buildVideoWidget(),
      ),
    );
  }

  Widget buildVideoWidget() {
    if (widget.isScroll) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/image/welcome.png",
          fit: BoxFit.fitWidth,
        ),
      );
    }
    return VideoDetailWidget2(
      streamController: widget.streamController,
    );
  }
}
