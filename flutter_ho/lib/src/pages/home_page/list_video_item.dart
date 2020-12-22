import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ListVideoItem extends StatefulWidget {
  ListVideoItem({Key key}) : super(key: key);

  @override
  _ListVideoItemState createState() => _ListVideoItemState();
}

class _ListVideoItemState extends State<ListVideoItem> {
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.one_k),
              Text("早起的年轻人"),
            ],
          ),
          Container(
            height: 160,
            child: Stack(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlayController() {
    if (_isPlay) {
      return Container();
    } else {
      return Positioned.fill(
        child: Container(
          // 0.3透明度
          color: Colors.blueGrey.withOpacity(0.3),
          child: GestureDetector(
            onTap: () {
              _isPlay = true;
              setState(() {});
              _controller.play();
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
