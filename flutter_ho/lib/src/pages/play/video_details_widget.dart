import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailWidget extends StatefulWidget {
  final StreamController streamController;
  VideoDetailWidget({Key key, this.streamController}) : super(key: key);

  @override
  _VideoDetailWidgetState createState() => _VideoDetailWidgetState();
}

class _VideoDetailWidgetState extends State<VideoDetailWidget> {
  /// 创建视频播放器
  VideoPlayerController _controller;

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
    if (_isPlay) {
      return Container();
    } else {
      return Positioned.fill(
        child: Container(
          // 0.3透明度
          color: Colors.blueGrey.withOpacity(0.5),
          child: GestureDetector(
            onTap: () {
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
            },
            child: Icon(
              Icons.play_circle_fill,
              size: 44,
            ),
          ),
        ),
      );
    }
  }
}
