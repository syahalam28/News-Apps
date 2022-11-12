import 'dart:async';

import '../controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNews extends StatefulWidget {
  final String newsUrl;
  WebViewNews({Key? key, required this.newsUrl}) : super(key: key);

  @override
  State<WebViewNews> createState() => _WebViewNewsState();
}

class _WebViewNewsState extends State<WebViewNews> {
  NewsController newsController = NewsController();
  late WebViewController controller;

  // final Completer<WebViewController> controller =
  //     Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Web View'),
          actions: [
            IconButton(
                onPressed: () async {
                  controller.loadUrl(widget.newsUrl);
                },
                icon: const Icon(Icons.auto_fix_high_outlined))
          ],
        ),
        body: WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (WebViewController webViewController) {
          //   setState(() {
          //     controller.complete(webViewController);
          //   });
          // },

          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageStarted: (url) {
            print('New Website : $url ');
          },
        ));
  }
}
