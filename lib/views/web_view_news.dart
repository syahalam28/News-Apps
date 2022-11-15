import 'dart:async';

import '../controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/color_constants.dart';
import '../constants/size_constants.dart';

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
          iconTheme: const IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.burgundy,
          elevation: 3.0,
          centerTitle: true,
          toolbarHeight: Sizes.dimen_64,
          title: const Text('Octo News'),
          actions: [
            IconButton(
              tooltip: "Reload Page",
              onPressed: () async {
                controller.loadUrl(widget.newsUrl);
              },
              icon: const Icon(Icons.refresh_outlined),
            )
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
