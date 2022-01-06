import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewPage extends StatefulWidget {
  String htmlUrl;
  String pageTitle;

  CommonWebViewPage({required this.htmlUrl, this.pageTitle = ""});

  @override
  _CommonWebViewPageState createState() {
    // TODO: implement createState
    return _CommonWebViewPageState();
  }
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      backgroundColor: Colors.white,
      body: WebView(
        initialUrl: widget.htmlUrl,
      ),
    );
  }
}
