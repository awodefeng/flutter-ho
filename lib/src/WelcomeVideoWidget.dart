import 'package:flutter/material.dart';
import 'package:mobile_lander/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

//倒计时页面的视频播放
class WelcomeVideoWidget extends StatefulWidget {
  @override
  _WelcomeVideoState createState() {
    // TODO: implement createState
    return _WelcomeVideoState();
  }
}

class _WelcomeVideoState extends State<WelcomeVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/welcom.mp4')
          ..initialize().then((value) {
            LogUtils.e("duanjinqian", "加载完成");
            _controller.play();
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _controller.value.isInitialized
        ? SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    )
        : Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
