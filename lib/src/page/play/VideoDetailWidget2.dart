import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_lander/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

class VideoDetailWidget2 extends StatefulWidget {
  final StreamController? streamController;

  VideoDetailWidget2({this.streamController});

  @override
  _VideoDetailWidget2State createState() {
    // TODO: implement createState
    return _VideoDetailWidget2State();
  }
}

class _VideoDetailWidget2State extends State<VideoDetailWidget2> {
  late VideoPlayerController _controller;
  bool _isPlay = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        //第一层视频播放
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              _controller.pause();
              _isPlay = false;
              setState(() {});
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        //第二层控制层
        buildPositioned()
      ],
    );
  }

  Widget buildPositioned() {
    //正在播放隐藏控制层
    if (_isPlay) {
      return Container();
    }
    return Positioned.fill(
      child: Container(
        //0.3透明度
        color: Colors.blueGrey.withOpacity(0.5),
        child: GestureDetector(
          onTap: () {
            //发送消息
            //先暂停再播放
            if (widget.streamController != null) {
              widget.streamController!.add(_controller);
            }
            //当前视频播放的位置
            Duration position = _controller.value.position;

            //视频的总长度
            Duration duration = _controller.value.duration;
            if (position == duration) {
              //播放完毕 再点击播放的时候播放位置重置到开始位置
              _controller.seekTo(Duration.zero);
            }
            //开始播放
            _controller.play();
            _isPlay = true;
            setState(() {});
          },
          child: const Icon(
            Icons.play_circle_fill,
            size: 44,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/list_item.mp4')
      ..initialize().then((value) {
        LogUtils.e("duanjinqian", "加载完成");
        setState(() {});
      });

    _controller.addListener(() {
      if (_isPlay && !_controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
