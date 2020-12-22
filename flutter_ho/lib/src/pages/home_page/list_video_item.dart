import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/play/video_details_widget.dart';
import 'package:video_player/video_player.dart';

class ListVideoItem extends StatefulWidget {
  final StreamController streamController;
  final bool isSroll;
  ListVideoItem({Key key, this.streamController, this.isSroll = false})
      : super(key: key);

  @override
  _ListVideoItemState createState() => _ListVideoItemState();
}

class _ListVideoItemState extends State<ListVideoItem> {
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
          SizedBox(
            height: 8,
          ),
          Container(
            height: 220,
            child: buildVideoWidget(),
          ),
        ],
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
