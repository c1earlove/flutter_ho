import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/play/video_details_widget.dart';
import 'package:flutter_ho/src/pages/play/video_details_widget2.dart';
import 'package:video_player/video_player.dart';

class ListVideoItem2 extends StatefulWidget {
  final StreamController streamController;
  final bool isSroll;
  ListVideoItem2({Key key, this.streamController, this.isSroll = false})
      : super(key: key);

  @override
  _ListVideoItem2State createState() => _ListVideoItem2State();
}

class _ListVideoItem2State extends State<ListVideoItem2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(10),
      child: Container(
        height: 220,
        child: VideoDetailWidget2(),
      ),
    );
  }

  Widget buildVideoWidget() {
    if (widget.isSroll) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/images/welcome.png",
          fit: BoxFit.fitWidth,
        ),
      );
    } else {
      return VideoDetailWidget(
        streamController: widget.streamController,
      );
    }
  }
}
