import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home_page/list_video_item.dart';

class HomeItemPage extends StatefulWidget {
  final int flag;
  HomeItemPage({Key key, this.flag}) : super(key: key);

  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("你好"),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListVideoItem();
        },
      ),
    );
  }
}
