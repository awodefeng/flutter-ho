import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_lander/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

class VideoDetailWidget extends StatefulWidget {
  final StreamController? streamController;

  VideoDetailWidget({this.streamController});

  @override
  _VideoDetailWidgetState createState() {
    // TODO: implement createState
    return _VideoDetailWidgetState();
  }
}

class _VideoDetailWidgetState extends State<VideoDetailWidget> {
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

  late Timer _timer;
  double _opacity = 1.0;

  Widget buildPositioned() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1200),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opacity = 1.0;
          });
          _timer = Timer(const Duration(seconds: 3), () {
            setState(() {
              _opacity = 0.0;
            });
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                //0.3透明度
                color: Colors.blueGrey.withOpacity(0.5),
                child: GestureDetector(
                  onTap: () {
                    if (_controller.value.isPlaying) {
                      stopVideo();
                      if (_timer.isActive) {
                        _timer.cancel();
                      }
                    } else {
                      startPlayVideo();
                      //创建3秒延迟的计时器
                      _timer = Timer(const Duration(seconds: 3), () {
                        setState(() {
                          _opacity = 0.0;
                        });
                      });
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [
                            Colors.black,
                            Colors.black.withOpacity(0.3)
                          ])),
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow_sharp,
                            size: 33,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //顶部对齐的文本
            const Positioned(
              top: 10,
              left: 10,
              right: 10,
              height: 44,
              child: Text(
                "努力奋斗",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            //底部滑动条
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              height: 60,
              child: buildBottomController(),
            )
          ],
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

    //视频播放器的监听器 实时更新
    _controller.addListener(() {
      if (_isPlay && !_controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }

      //视屏播放的当前进度
      Duration currDuration = _controller.value.position;
      //视频的总时长
      Duration totalDuration = _controller.value.duration;
      //进度条的当前进度值
      _currentSlider =
          currDuration.inMilliseconds / totalDuration.inMilliseconds;
      if (_opacity == 1.0) {
        _streamController.add(0);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _streamController.close();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  //开始播放视频
  void startPlayVideo() {
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
    _isFirst = false;
    setState(() {});
  }

  double _currentSlider = 0.0;
  bool _isFirst = true;
  StreamController<int> _streamController = new StreamController();

  buildBottomController() {
    if (_isFirst) {
      return Container();
    }
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Row(
          children: [
            Text(
              buildStartText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Expanded(
              child: Slider(
                //滑动条当前进度
                value: _currentSlider,
                //滑动条滑动时的回调
                onChanged: (value) {
                  setState(() {
                    _currentSlider = value;
                    //控制视频
                    _controller.seekTo(_controller.value.duration * value);
                  });
                },
                min: 0.0,
                max: 1.0,
                //滑动条背景色
                inactiveColor: Colors.white,
                //滑动条前景色
                activeColor: Colors.redAccent,
              ),
            ),
            Text(
              buildTotalText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            )
          ],
        );
      },
    );
  }

  //获取当前实时播放时间
  String buildStartText() {
    //当前播放进度
    Duration duration = _controller.value.position;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }

    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }
    return "$mStr:$sStr";
  }

  //获取总播放时间
  String buildTotalText() {
    //总时间
    Duration duration = _controller.value.duration;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }

    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }
    return "$mStr:$sStr";
  }

  void stopVideo() {
    _controller.pause();
    _isPlay = false;
  }
}
