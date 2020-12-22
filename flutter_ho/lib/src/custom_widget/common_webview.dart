import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewPage extends StatefulWidget {
  final String htmlUrl;
  final String pageTitle;
  CommonWebViewPage({Key key, @required this.htmlUrl, this.pageTitle = ""})
      : super(key: key);

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.pageTitle}"),
      ),
      body: WebView(
        initialUrl: widget.htmlUrl,
      ),
    );
  }
}
