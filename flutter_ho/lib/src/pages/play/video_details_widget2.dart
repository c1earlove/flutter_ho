import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_util.dart';
import 'package:video_player/video_player.dart';

class VideoDetailWidget2 extends StatefulWidget {
  final StreamController streamController;
  VideoDetailWidget2({Key key, this.streamController}) : super(key: key);

  @override
  _VideoDetailWidget2State createState() => _VideoDetailWidget2State();
}

class _VideoDetailWidget2State extends State<VideoDetailWidget2> {
  /// 创建视频播放器
  VideoPlayerController _controller;
  double _currentSlider = 0.0;
  Timer _timer;
  double _opacity = 1.0;

  /// 视频是否播放
  bool _isPlay = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/list_item.mp4")
      ..initialize().then((value) {
        setState(() {});
      });
    _controller.addListener(() {
      // 视频播放器 添加监听
      // 当视频播放状态为播放 但是控制器状态为不播放时  要更新视频播放状态
      if (_isPlay && !_controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }
      Duration currentDuration = _controller.value.position;
      Duration totalDuration = _controller.value.duration;
      _currentSlider =
          currentDuration.inMilliseconds / totalDuration.inMilliseconds;
      // 实时更新进度条
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 第一层 视频播放
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
        // 第二层 视频控制
        buildPlayController()
      ],
    );
  }

  Widget buildPlayController() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1200),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opacity = 1.0;
          });
          _timer = Timer(Duration(seconds: 3), () {
            setState(() {
              _opacity = 0.0;
            });
          });
        },
        child: Stack(
          children: [
            // 视频显示图层
            Positioned.fill(
              child: Container(
                // 0.3透明度
                color: Colors.blueGrey.withOpacity(0.5),
                child: GestureDetector(
                  onTap: () {
                    if (_controller.value.isPlaying) {
                      // 暂停播放
                      stopPlayVideo();
                      if (_timer.isActive) {
                        _timer.cancel();
                      }
                    } else {
                      // 开始播放
                      startPlayVideo();
                      // 延时三秒的演示器
                      _timer = Timer(Duration(seconds: 3), () {
                        setState(() {
                          _opacity = 0.0;
                        });
                      });
                    }
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_circle_fill,
                    size: 44,
                  ),
                ),
              ),
            ),
            // 视频标签
            Positioned(
              child: Text(
                "早起的年轻人",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              top: 10,
              left: 10,
              right: 10,
              height: 44,
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              height: 40,
              child: bottomSliderWidget(),
            ),
            // 进度条
          ],
        ),
      ),
    );
  }

  /// 开始播放视频
  void startPlayVideo() {
    _isPlay = true;
    // 发送消息
    // 先暂停在播放
    if (widget.streamController != null) {
      widget.streamController.add(_controller);
    }
    // 视频总长度
    Duration duration = _controller.value.duration;
    // 当前视频播放的长度
    Duration postion = _controller.value.position;
    if (duration == postion) {
      // 视频总长度 = 当前长度  说明视频已经播放完成
      //把播放长度重置为0 就可以继续播放
      _controller.seekTo(Duration.zero);
    }
    // 开始播放视频
    _controller.play();
    setState(() {});
  }

  // 下面进度条widget
  Widget bottomSliderWidget() {
    return Row(
      children: [
        Text(
          buildStartText(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Slider(
            min: 0.0,
            max: 1.0,
            // 滑动条颜色
            inactiveColor: Colors.white,
            // 滑动条进度颜色
            activeColor: Colors.redAccent,
            value: _currentSlider,
            onChanged: (value) {
              kLog("当前滑动进度：$value");
              setState(() {
                _currentSlider = value;
                _controller.seekTo(_controller.value.duration * value);
              });
            },
          ),
        ),
        Text(
          buildFinishText(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  // 开始时间
  String buildStartText() {
    // 获取当前播放时间
    Duration duration = _controller.value.position;
    int m = duration.inMinutes;
    int s = duration.inSeconds;
    // 分钟
    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    // 秒
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }
    return "$mStr:$sStr";
  }

  String buildFinishText() {
    // 视频总时长
    Duration duration = _controller.value.duration;
    int m = duration.inMinutes;
    int s = duration.inSeconds;
    // 分钟
    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    // 秒
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }
    return "$mStr:$sStr";
  }

  void stopPlayVideo() {
    _controller.pause();
    _isPlay = false;
  }
}
