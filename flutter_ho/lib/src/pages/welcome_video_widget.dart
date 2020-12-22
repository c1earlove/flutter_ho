import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_util.dart';

class WelcomeVideoWidget extends StatefulWidget {
  WelcomeVideoWidget({Key key}) : super(key: key);

  @override
  _WelcomeVideoWidgetState createState() => _WelcomeVideoWidgetState();
}

class _WelcomeVideoWidgetState extends State<WelcomeVideoWidget> {
  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      // "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
      "assets/video/qidong.mp4",
    )..initialize().then((value) {
        kLog("加载完毕");
        _videoPlayerController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.initialized
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ),
          )
        : Container();
  }
}
