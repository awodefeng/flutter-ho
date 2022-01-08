import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'ListItemWidget.dart';
import 'ListItemWidget2.dart';

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
  final StreamController _streamController = StreamController.broadcast();
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController.stream.listen((event) {
      if (_videoPlayerController != null &&
          _videoPlayerController.textureId != event.textureId) {
        _videoPlayerController.pause();
      }
      _videoPlayerController = event;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  bool _isScroll = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        backgroundColor: Colors.grey[200],
        body: NotificationListener(
          onNotification: (ScrollNotification notification) {
            Type runtimeType = notification.runtimeType;
            if (runtimeType == ScrollStartNotification) {
              _isScroll = true;
            } else if (runtimeType == ScrollEndNotification) {
              _isScroll = false;
              setState(() {});
            }
            return false;
          },
          child: ListView.builder(
              //缓存距离为0
              cacheExtent: 0,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return buildListItemFunction();
              }),
        ));
  }

  Widget buildListItemFunction() {
    if(widget.flag == 1){
      return ListItemWidget(
        isScroll: _isScroll,
        streamController: _streamController,
      );
    }else{
      return ListItemWidget2(
        isScroll: _isScroll,
        streamController: _streamController,
      );
    }

  }
}
