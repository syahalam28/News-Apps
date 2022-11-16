import 'dart:async';

import 'package:get/get.dart';
import 'package:news_project/controllers/authC.dart';
import 'package:news_project/utils/route_name.dart';
import 'package:news_project/views/home_page.dart';
import 'package:restart_app/restart_app.dart';

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
  final authC = Get.put(AuthC());

  // final Completer<WebViewController> controller =
  //     Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 3.0,
          centerTitle: true,
          toolbarHeight: Sizes.dimen_64,
          title: const Text(
            'Octo News',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              tooltip: "Reload Page",
              onPressed: () async {
                controller.loadUrl(widget.newsUrl);
              },
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.black,
              ),
            ),
            authC.isAuth.isTrue
                ? IconButton(
                    tooltip: "Home",
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                      Restart.restartApp(webOrigin: RouteName.home);
                    },
                    icon: const Icon(
                      Icons.newspaper_rounded,
                      color: Colors.black,
                    ),
                  )
                : Text("")
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
