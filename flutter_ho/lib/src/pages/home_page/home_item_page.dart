import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home_page/list_video_item.dart';
import 'package:flutter_ho/src/utils/log_util.dart';
import 'package:video_player/video_player.dart';

class HomeItemPage extends StatefulWidget {
  final int flag;
  HomeItemPage({Key key, this.flag}) : super(key: key);

  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {
  /// 创建一个多订阅流
  StreamController _streamController = StreamController();
  // 全局的视频播放控制器 赋值用
  VideoPlayerController _videoPlayerController;
  bool _isScroll = false;
  @override
  void initState() {
    super.initState();
    //  添加一个消息监听
    _streamController.stream.listen((event) {
      // event.textureId 视频播放器唯一标识
      kLog("接收到消息 ${event.textureId}");
      if (_videoPlayerController != null &&
          _videoPlayerController.textureId != event.textureId) {
        _videoPlayerController.pause();
      }
      _videoPlayerController = event;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("你好"),
      ),
      backgroundColor: Colors.grey[200],
      body: NotificationListener(
        onNotification: (notification) {
          Type runtimeType = notification.runtimeType;
          if (runtimeType == ScrollStartNotification) {
            kLog("开始滑动");
            _isScroll = true;
          } else if (runtimeType == ScrollEndNotification) {
            kLog("滑动结束");
            _isScroll = false;
            setState(() {});
          }

          return false;
        },
        child: ListView.builder(
          // 缓存距离为0
          cacheExtent: 0,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ListVideoItem(
              streamController: _streamController,
              isSroll: _isScroll,
            );
          },
        ),
      ),
    );
  }
}
